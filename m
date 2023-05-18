Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4895708973
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzk9y-0000WV-E6; Thu, 18 May 2023 16:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzk94-0008SQ-5b
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzk91-000137-Gs
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684441358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qCs3h/HmgbikYbubyedMbedVNl4lK/NOXo/o04rzEM=;
 b=VKWOFEs6nbkLtDGQUnJQJz8kei2VpuM25EwHctlYXxrew2o2tW2RtxXsrTxGtMGlsY6dO3
 hJl7Y8KBPfo8Mg1sy59RvtZ/tpnqlSjb0wCkdqhTpSPGV1XBGKgFRfrPq33mCs3jq3HAt7
 p2TW6krYM+dXLNmlBEH77ZWurwe3Pnk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-gD0uK-wlNC2DcaOCT95IEA-1; Thu, 18 May 2023 16:22:36 -0400
X-MC-Unique: gD0uK-wlNC2DcaOCT95IEA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4ef455ba61cso1761262e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 13:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684441355; x=1687033355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qCs3h/HmgbikYbubyedMbedVNl4lK/NOXo/o04rzEM=;
 b=ARUCHEC4DRQgeU4le8kyC93sih6+Bdd0NjV2fXF18K/6+EuSiAzBW/V+pLp1LpnveA
 xp4qGkzblQRXcqjh1HW3PixyXuaNK8JZYdIEWFDTx1bOKje7T0Vo9Knpm1MIqK8OadZa
 3eF9ZTDNiLvEwGJ7sUII6FghlFXN4QNxPPDEt9lLyT+GTn9DKYCfdRb1p9zHGApp3cAZ
 y8YkpdwWmCAYtF8AfQeul+6z9VV/SyvVGSGUreafpQ+O7T+TP/AbsYUJOzX97nRDd/ZP
 0LIOM4rxy9u5Xih/demvd97+Ne3Oi6P0PwFyyimiNqleJitlxp27rJUAMnAaLK8X0uVM
 QSwg==
X-Gm-Message-State: AC+VfDwP09/GtxmMqH8eq7PnOBcG3IHp8qPZND1SJ1AavzFmIFyOyBSn
 43vUrcAuucji8FwfH/DBc1NHU9cAr+fjlJjcHoY7tFxSoX2w+MjZYAwos/tevtBx22U0xozD/bN
 NNRFm2+greEh95w4=
X-Received: by 2002:ac2:55af:0:b0:4f2:6bc3:5e33 with SMTP id
 y15-20020ac255af000000b004f26bc35e33mr62250lfg.9.1684441355326; 
 Thu, 18 May 2023 13:22:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4H3MXcftPekEqYrn0fOLU9IREvCFo+KIpa+HPY9ufFQZjzL0e82T3BH4MIJbTZfvuJ7ejwPg==
X-Received: by 2002:ac2:55af:0:b0:4f2:6bc3:5e33 with SMTP id
 y15-20020ac255af000000b004f26bc35e33mr62229lfg.9.1684441355025; 
 Thu, 18 May 2023 13:22:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 z1-20020ac24181000000b004f11e965308sm363910lfh.20.2023.05.18.13.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 13:22:34 -0700 (PDT)
Date: Thu, 18 May 2023 16:22:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bandan Das <bsd@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bin Meng <bin.meng@windriver.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Jon Maloy <jmaloy@redhat.com>, Siqi Chen <coc.cyqh@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v10 8/8] apic: disable reentrancy detection for apic-msi
Message-ID: <20230518162205-mutt-send-email-mst@kernel.org>
References: <20230427211013.2994127-1-alxndr@bu.edu>
 <20230427211013.2994127-9-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427211013.2994127-9-alxndr@bu.edu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Apr 27, 2023 at 05:10:13PM -0400, Alexander Bulekov wrote:
> As the code is designed for re-entrant calls to apic-msi, mark apic-msi
> as reentrancy-safe.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


feel free to merge with rest of patchset - who's going to
merge it btw?

> ---
>  hw/intc/apic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index 20b5a94073..ac3d47d231 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -885,6 +885,13 @@ static void apic_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->io_memory, OBJECT(s), &apic_io_ops, s, "apic-msi",
>                            APIC_SPACE_SIZE);
>  
> +    /*
> +     * apic-msi's apic_mem_write can call into ioapic_eoi_broadcast, which can
> +     * write back to apic-msi. As such mark the apic-msi region re-entrancy
> +     * safe.
> +     */
> +    s->io_memory.disable_reentrancy_guard = true;
> +
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, apic_timer, s);
>      local_apics[s->id] = s;
>  
> -- 
> 2.39.0


