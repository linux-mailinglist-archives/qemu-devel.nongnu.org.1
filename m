Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D07E0481
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:16:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuxL-00023f-06; Fri, 03 Nov 2023 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1qyuxI-00022y-Lb
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1qyuxG-0001GW-He
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699020921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=oUqO+lPnXw4HE5Xvy3d7PnKvCfvewKp1ujzp/SdHd7I=;
 b=XQi53fwSUNaBJBoagOg1XS4uDvWgEqit2Om/RoqvLKxNwkbxn35J+AvYU67GRdpYfOP9DR
 jHgwKzxZnKmrGFNNnlaoufYL9mrC1Ki7qplmm9tMEeWGNIEJSFymlPaYX1ZJq4TYfXO65t
 /ATGBM7RP7tMOLECe6q/VQI4zc/Q4BY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-32ojAH7lMYis1r4T3nDSyg-1; Fri, 03 Nov 2023 10:14:11 -0400
X-MC-Unique: 32ojAH7lMYis1r4T3nDSyg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d0b251a6aso22215196d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699020849; x=1699625649;
 h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUqO+lPnXw4HE5Xvy3d7PnKvCfvewKp1ujzp/SdHd7I=;
 b=vV9YGFtJO5u5XPTXw4p+BTAok8lF7w8pOBEMaXJeLoVWtwgs8Qf9KY0mTXharUV843
 XnA70qqoVyPOxdm6QnI2rcWFRVLtK+T24Spng4xCM8nhNLBw/otlhaFohorYoUUpsc0d
 ZTVLWcpPiseFaKqOmzXUp+z5mjDXL2m4ql4+gv0Ws3nzgcyT+1WgGXI0TQSNMXrZ7E8p
 RYkwV4GAAoYrXzJ0MWWPDWFjXDiE2dRuG7/ow7RHDdfXkNTxdECoiJNLLxD1cV1rdESb
 4gitZYaqqxLsQh3VaZcq/Nqshk7UTomJDAH+0wrEMsBrA8tOGezKFp+R/VYcnTvNt2Dl
 rJbg==
X-Gm-Message-State: AOJu0YxMGu7eL89ICqCTPKusfirNwJbiBWz9EAK1P8qCtk+ezZA6LeHa
 ZIyIszJA3RAJaSYQuicnv1HnPbuzVaXcBty5I00BCWdiNjoootMeXTaEVGj9BsjMhocbAzbFgto
 fGRjQ5ua+FgDGZf/i3UDNCmSFC+MaTDkPCizdPLEzsaAlnLp5zoyRFoEdwiFMyVdT8vFx22uO
X-Received: by 2002:a05:6214:212e:b0:66d:6458:d9f8 with SMTP id
 r14-20020a056214212e00b0066d6458d9f8mr29946428qvc.54.1699020849508; 
 Fri, 03 Nov 2023 07:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnOPlzlKPKMJd81/xceBkWCY3GSICsV4nl86wnlQ8O+rlzkAyQZU2h7rQjKBUNlpe8eY+oWw==
X-Received: by 2002:a05:6214:212e:b0:66d:6458:d9f8 with SMTP id
 r14-20020a056214212e00b0066d6458d9f8mr29946396qvc.54.1699020849160; 
 Fri, 03 Nov 2023 07:14:09 -0700 (PDT)
Received: from rh (p200300c93f06be0024aad376da864a75.dip0.t-ipconnect.de.
 [2003:c9:3f06:be00:24aa:d376:da86:4a75])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a0ce6ca000000b0066d15724feesm767737qvn.68.2023.11.03.07.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 07:14:08 -0700 (PDT)
Date: Fri, 3 Nov 2023 15:14:05 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: qemu-devel@nongnu.org
cc: Leif Lindholm <quic_llindhol@quicinc.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/arm: fix PMU IRQ registration
Message-ID: <475d918d-ab0e-f717-7206-57a5beb28c7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
PMU IRQ registration fails for arm64 guests:

[    0.563689] hw perfevents: unable to request IRQ14 for ARM PMU counters
[    0.565160] armv8-pmu: probe of pmu failed with error -22

That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
where the PMU IRQ is actually referred by its PPI index. Fix that by using
INTID_TO_PPI() in that case.

Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
  hw/arm/virt.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 92085d2d8f..0a16ab3095 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -631,7 +631,8 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
          qemu_fdt_setprop(ms->fdt, "/pmu", "compatible",
                           compat, sizeof(compat));
          qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_PMU_IRQ, irqflags);
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
      }
  }

-- 
2.41.0


