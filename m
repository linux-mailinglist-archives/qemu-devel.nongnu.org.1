Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D911471269B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WYP-0006UO-Fe; Fri, 26 May 2023 08:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2WYN-0006Tx-FC
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2WYK-0001Rv-1f
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685104095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtiD3n0xqzweht8/Gv0i9BvBIxGaNH4Rmey7VHEK4sg=;
 b=L8e60HaIII01R2KxTE6StMWygPE9fbOsVlFjmktA4AJnF/uyjKIAG4/k5FA1jn/22YvoC4
 F9jbtBsFaDm/sU4ST0jqlNG5tiyBG5Y/2s8k9+KogdUaXwTuX9rCw3HgsgDQKEKbBqbq/p
 HVyEdb7xL/AjVhk8V8m1QGzF4tAGAoA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-0JmPpKVGOUuAO-jN3sE38g-1; Fri, 26 May 2023 08:28:13 -0400
X-MC-Unique: 0JmPpKVGOUuAO-jN3sE38g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fd3757bd1so88051666b.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685104092; x=1687696092;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RtiD3n0xqzweht8/Gv0i9BvBIxGaNH4Rmey7VHEK4sg=;
 b=eYTpn7Rw4cIiNT9RYbPfRRlWw4jb6hOYdzM5FtyonFYOyBm4bv6KAZY6UctIU/KuLR
 E7fbL5S050xDW7Ew1G0mzf+hRrzlzJdNVErsIQKkjx9nRjMD9A/VHYdF115OrlttlZiy
 TZMrTxPvbxdH39QN6AkI6z9nZtjkhtHf7p2JuPdxmq3yZiVenvW3NFhPkq+XWg43rKHu
 nefwXbN1OelchAAbxplnD7eLS8ZyAv0FPM9yBIeCEbVqoIKmX+So4FxHCCilOzAxWo+m
 5ACEMjKos8cEhtUxkgn28TNWvhOFJFkQihuk6zKPmg+ZB6yH00YKImY85cV3YLu3wXuL
 hS/Q==
X-Gm-Message-State: AC+VfDw0Y5YDpt5m+Jt1yKRbhc7ukCANvFohDRuwywLLWmfoBNRd0zNj
 6/I5thhA9s43JhGVLcpTh5nFw1P2En1oqFligutsxi75ZZYGisaRtK43C9EPO9lu253vByf6zLf
 XwO1IJm6mBPsBXM8=
X-Received: by 2002:a17:907:7d8f:b0:96b:e93:3aa8 with SMTP id
 oz15-20020a1709077d8f00b0096b0e933aa8mr1795636ejc.21.1685104092417; 
 Fri, 26 May 2023 05:28:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xrBkVeCi+QSXgoFxjE58wnOAhRAXk875nWHTn/+tJ4sUgcBD1gIfM7VVjKg2PdH/w13wPgQ==
X-Received: by 2002:a17:907:7d8f:b0:96b:e93:3aa8 with SMTP id
 oz15-20020a1709077d8f00b0096b0e933aa8mr1795602ejc.21.1685104092067; 
 Fri, 26 May 2023 05:28:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 k17-20020a170906681100b0096f7105b3a6sm2087364ejr.189.2023.05.26.05.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:28:11 -0700 (PDT)
Date: Fri, 26 May 2023 14:28:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 05/10] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol
 in Kconfig
Message-ID: <a3hd3rje27tezeudobqrywboblub7s2g2j45qxhu65oqbkper3@vqfcxmv23z55>
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524093744.88442-6-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 24, 2023 at 11:37:39AM +0200, Philippe Mathieu-Daudé wrote:
>Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
>and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
>selected by both symbols.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>Reviewed-by: Thomas Huth <thuth@redhat.com>
>---
> hw/virtio/Kconfig     | 6 ++++++
> hw/virtio/meson.build | 5 +++--
> 2 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


