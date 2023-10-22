Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C437D2223
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgZ-0006al-UQ; Sun, 22 Oct 2023 05:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgW-0006HJ-Pg
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgV-0000Qi-64
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9P1PewEfPu9iKkwPBAPgV0XPlfzyAO697drDJLVfyA=;
 b=aX+pcfsqXXt5kssG/C34fJ5LZLGA4yX9CUil42W8esUFr4Z08IwvwAo6d5mVapLPo5ZA+N
 Ez+ejDAp4X1IzEl2ALBZfDpftF/GEogFrf1cY61VvKt0yi2ldWlgO/JB2s6XUxPEIV/HHM
 IesTsAcNveBJq7HehNEEbsVtLAOfRjU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-EGX7ZTa3PEeI1kqUDzZF9A-1; Sun, 22 Oct 2023 05:23:29 -0400
X-MC-Unique: EGX7ZTa3PEeI1kqUDzZF9A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507be692ce4so2242378e87.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966608; x=1698571408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9P1PewEfPu9iKkwPBAPgV0XPlfzyAO697drDJLVfyA=;
 b=oN/yTo+7Y2zdgUugPl+CiFA4aGwPyPwdV1gN3t9Ij0LfcXfEIPUTHTI5nvrR1MQyfx
 NIzDuyiMs25NhdB1rmRClYyKkG1tspvmyiFze4RVupiLN/YsqZVM7rHeCzZ3dSlH0p73
 /N195q7IHn2xWvDr/C2njgskRtHbID9IH5A6hVKmEHIsOUOOK1tblcESFK5nQbV2Jib7
 X0HNyIxlPz5Apd/KnhcSvxvAy1APc04wBu1AX44gnaUCZ3jgzhRwdXZG6sSHSnU1LRsU
 63uXwVDP/h3F96L5mxN06zkFrwu1fp3KKjlDR9exhJZNezHHiGZrkmrsi2VWoMfdJwz8
 51xA==
X-Gm-Message-State: AOJu0YwUui/1a1zG5Dp8UE4yZuSl4c5bseYsClbZ/E9ngrrYLfaalpJl
 BjdwoA/jHHf8k/RzAAbMS7UmQcbiXQhzL1fbS80yxZnnr3G+nLURoTDmFmOj9shno1VUUQqnIy2
 Zb6sHrvyP0DHJkuzRTWdbg+QSrTWq6zUlKdis4Ugi9Civx5s+IMnRWujjYiUjp/j7ShUS
X-Received: by 2002:ac2:5e2d:0:b0:504:31a0:f9e2 with SMTP id
 o13-20020ac25e2d000000b0050431a0f9e2mr4121825lfg.58.1697966608062; 
 Sun, 22 Oct 2023 02:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFp8wtxKKHthY2tU1hK+oRjRhJqwIbkSM9sPzG1izGss8xUU2TvuG7xaJhIDomYGh0H0dvvA==
X-Received: by 2002:ac2:5e2d:0:b0:504:31a0:f9e2 with SMTP id
 o13-20020ac25e2d000000b0050431a0f9e2mr4121816lfg.58.1697966607762; 
 Sun, 22 Oct 2023 02:23:27 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 d5-20020adffbc5000000b003233b554e6esm5222188wrs.85.2023.10.22.02.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:27 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Damien Zammit <damien@zamaudio.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 20/62] timer/i8254: Fix one shot PIT mode
Message-ID: <74d7ea50627a60257a92e77402780897075654fd.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Damien Zammit <damien@zamaudio.com>

Currently, the one-shot (mode 1) PIT expires far too quickly,
due to the output being set under the wrong logic.
This change fixes the one-shot PIT mode to behave similarly to mode 0.

TESTED: using the one-shot PIT mode to calibrate a local apic timer.

Signed-off-by: Damien Zammit <damien@zamaudio.com>

Message-Id: <20230226015755.52624-1-damien@zamaudio.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/timer/i8254_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index e4093e2904..b25da448c8 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -52,10 +52,8 @@ int pit_get_out(PITChannelState *s, int64_t current_time)
     switch (s->mode) {
     default:
     case 0:
-        out = (d >= s->count);
-        break;
     case 1:
-        out = (d < s->count);
+        out = (d >= s->count);
         break;
     case 2:
         if ((d % s->count) == 0 && d != 0) {
-- 
MST


