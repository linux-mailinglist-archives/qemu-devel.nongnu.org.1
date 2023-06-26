Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122BD73E100
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmZu-0002Dr-8i; Mon, 26 Jun 2023 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmZs-0002DS-0o
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmZq-00057f-DF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOIPsro+RnMpGMZCoPUgAfihsrkd5HEoKxKvLoL5Tw0=;
 b=eqA4iCY7VWarO7+Lb6V7NI56PYzbmn7EkVOUnc+0nis3Qjk8mmp9K0tJB9k+sLANz9RePX
 5b/UXYz0lOq9dTf0xw81bIC1isKjz2HZtDx9XJDPQDl4C8BtQId8JGRgoXs59yJM8daYFn
 JtUckxRT5m5QUHFisre9NDAzCpGYHKs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-FN32Pe5LNfeOd_Bk4OHxVw-1; Mon, 26 Jun 2023 09:48:19 -0400
X-MC-Unique: FN32Pe5LNfeOd_Bk4OHxVw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98e1085308eso206236466b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787298; x=1690379298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOIPsro+RnMpGMZCoPUgAfihsrkd5HEoKxKvLoL5Tw0=;
 b=WwdwDpRKjKDoXF/lLfdJ5fpuS862jzhy4USTXHJSaKOtF35f8/c3Z6NXWwEvajX1fs
 3dQs9pbDkdLF6nsVJeZPMnAhgFWHp00ZxGPsEU/0r8gk5Gf7CFlmj0tTmOwwvOSSZkSX
 XDmxfq6OzNxi1Ru2VmL7f6Ki2HVu80ndE//TaE71s5c/C/E1BSehTJ+zJVaYvrKlhgmW
 c7Lij7Jg5019Lot9HXEW+LcEgsu3YRUpXkFjzuSuV7UJJO6VEpQsIz3TSmUMWJ46C8Tf
 LNs7/YahzAPO2Npo+sNTYqzNiI6GxtA0yBlPVoy+HQh3HbfrMz+z5P2+OVyQb3fqc/00
 QpnA==
X-Gm-Message-State: AC+VfDyzphCyo99CHtBXwkFAMaKsrHfzHIUDC/IZGnSdB0zcz96Y3Iio
 1lgZcl13bjob74xpnoigCCwdI//zsB/Z0dsfSr3sD+9ic/S2YWX7xbiGCQzxp2bgWDwRFkZ/fhA
 bxKQbrBofRIoIly8=
X-Received: by 2002:a17:907:7ba5:b0:982:4b35:c0b6 with SMTP id
 ne37-20020a1709077ba500b009824b35c0b6mr28336310ejc.1.1687787298587; 
 Mon, 26 Jun 2023 06:48:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ586HFmaW+siWA/0kSOtl2wIf8eyQXrTmeo4wg+5QjmgWsYOlsJQ8a/WzdJqcHgOXCYWwdl7g==
X-Received: by 2002:a17:907:7ba5:b0:982:4b35:c0b6 with SMTP id
 ne37-20020a1709077ba500b009824b35c0b6mr28336289ejc.1.1687787298345; 
 Mon, 26 Jun 2023 06:48:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 l24-20020a1709060e1800b009783791b1a1sm3265020eji.121.2023.06.26.06.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:48:17 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:48:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 0/4] hw/smbios: Cleanup topology related variables
Message-ID: <20230626154817.60613bc5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 20 Jun 2023 18:39:54 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi all,
> 
> This is my v3 patch series based on 48ab886d3da4f ("Merge tag 'pull-
> target-arm-20230619' of https://git.linaro.org/people/pmaydell/qemu-arm
> into staging").
> 
> Compared with v2 [1], v3 introduces 2 helpers to wrap the calculation of
> threads/cores per socket so that smbios can use these 2 helpers directly
> to avoid calculation error caused by missing topology changes.
> 
> Also due to the introduction of these two helpers, I involve more people
> for review of this v3.

other than nitpicking in patch 1/4, the series looks good to me.

> 
> 
> Introduction
> ============
> 
> This patchset is split from my previous hybrid topology RFC [2].
> 
> There are three places for topology-related cleanup:
> 
> 1. Fix the calculation of the number of sockets.
> 
>    Due to the misuse of the smp.cpus variable and the change in the
>    meaning of smp.cores, the calculation of socket number in smbios is
>    incorrect. This can be fixed by using smp.sockets directly.
> 
> 2. Fix core count in type4.
> 
>    The meaning of smp.cores changed so that the calculation of cores
>    per socket became wrong.
> 
>    v3 introduces the helper "machine_topo_get_cores_per_socket()" to
>    wrap the calculation of cores per socket. This can help other modules
>    avoid calculation error caused by missing topology changes.
> 
> 3. Fix thread count in type4.
> 
>    I also found that the definition of thread count in type4 doesn't
>    match the spec (smbios 3.0.0) and cleaned it up as well.
> 
>    Similar to core count, v3 uses a new helper to fix this.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00072.html
> [2]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html
> 
> 
> Regards,
> Zhao
> 
> ---
> Zhao Liu (4):
>   machine: Add helpers to get cores/threads per socket
>   hw/smbios: Fix smbios_smp_sockets caculation
>   hw/smbios: Fix thread count in type4
>   hw/smbios: Fix core count in type4
> 
>  hw/smbios/smbios.c  | 16 ++++++++++------
>  include/hw/boards.h | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 


