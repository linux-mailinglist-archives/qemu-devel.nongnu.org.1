Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26FC1FC7C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 12:19:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEQfs-0000rd-1U; Thu, 30 Oct 2025 07:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vEQfp-0000rO-Hh
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:18:33 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vEQfm-0004cO-Ff
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1761823097; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NkQtdiuUdP94aMni7TQTc6UMEBIAHjCcMPVH+WCxsKsxItS6e7u6FxX5Et0Elz/SF9IW9QebhSZuu1FRbxS5gJIOmFZiQ+FOaAzgPmWu/P+pR6+Mmil1jin08F11/Wsnm+KYNM6AhDT7Pn1TwQuRK0DIoh51CG7uPLXzFCHYQpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1761823097;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5Y+7y4JJ1qH0NupV41k6g0kA7u65ycwoHaqu+NDCksQ=; 
 b=PIt+cbKj2rWFylrvL8kROuuVbo1vXZUyuBLocM8QBeoD5flabupKoklzWd4N1NfWRF3I1wCCh6y/Xzv4tEp8OWN/HXWzZ8O95L44ys5ImJ8nWdt6rovB1MfSrof/5EcfkvQymHX6YdZD08y7jK8RHxAJpam3Q80i3CPOFkBcv/E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761823097; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=5Y+7y4JJ1qH0NupV41k6g0kA7u65ycwoHaqu+NDCksQ=;
 b=YH87RN6kc6k8HGKwGNeacECVsu7RdW7r007/WF9g4I6vle1w3/ZCoklPo02DI++l
 B+yy/tOEniXuynLU7iaNLCx2jrWySXUf3JIhvZdmVG0sg1hZ4ThTIM3rnD/DPNiloh8
 gP/St9GM0Pg3dxcDj215fQOcP7YYFqI1XSMXtSsA=
Received: by mx.zohomail.com with SMTPS id 1761823096187869.1485756080995;
 Thu, 30 Oct 2025 04:18:16 -0700 (PDT)
Message-ID: <d3dab1b6-4637-42cd-af54-1613ceffce9c@collabora.com>
Date: Thu, 30 Oct 2025 14:18:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] virtio-gpu: Force RCU when unmapping blob
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-5-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251029-force_rcu-v1-5-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 10/29/25 09:12, Akihiko Odaki wrote:
> Unmapping a blob changes the memory map, which is protected with RCU.
> RCU is designed to minimize the read-side overhead at the cost of
> reclamation delay. While this design usually makes sense, it is
> problematic when unmapping a blob because the operation blocks all
> virtio-gpu commands and causes perceivable disruption.
> 
> Minimize such the disruption with force_rcu(), which minimizes the
> reclamation delay at the cost of a read-side overhead.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/display/virtio-gpu-virgl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 07f6355ad62e..71cde671c193 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -187,6 +187,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>          memory_region_set_enabled(mr, false);
>          memory_region_del_subregion(&b->hostmem, mr);
>          object_unparent(OBJECT(mr));
> +        force_rcu();
>      }
>  
>      return 0;
> 

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

