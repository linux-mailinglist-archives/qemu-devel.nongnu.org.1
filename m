Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8D7D019E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhH-0000Fj-Qe; Thu, 19 Oct 2023 14:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfc-00071Y-Lp
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfb-0000qm-6w
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9P1PewEfPu9iKkwPBAPgV0XPlfzyAO697drDJLVfyA=;
 b=bgssNpQaRbLnyHo5y38406jDFgma7fW0JregIeyf/esGN3gjLq5Z1+n/uk0uy/HZWBUXgS
 T/9hf/cFCcicdA81D2LU7A/DWNDqaCYdrqMbVYW1o1ZJZMZSuhR8I8lglLu7kyLEpaCDHx
 IT1TIW9SSchnntw1LpPK0XFF2lTKGho=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-9jsok1XCPramA0GP5ZYTJg-1; Thu, 19 Oct 2023 14:22:51 -0400
X-MC-Unique: 9jsok1XCPramA0GP5ZYTJg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50ef18b04so59242021fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739769; x=1698344569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9P1PewEfPu9iKkwPBAPgV0XPlfzyAO697drDJLVfyA=;
 b=vMpJU48mYqN8bX57UUQFaV8YvMGB72Vj+qD0z4flN3LA7TiswHFOxbDpalM+lfLzSw
 7sOKpmUQ5q8f4qjk0TmI0tuk5LOPVxjzUJoSERQWtsm7ym+uWoIbjGvo85an2CueYwr+
 KxZtd0R6sfXKrI4STTo62s9RukAONl4CVXeJFiZ3QCk5Nu3dNFtzh5rDDPGVM/iH+JSg
 V7qqSkgPTNK+zsHn/ElahTcw8u/R5tvQY3pLDPNjxtuTHiPwFXX0RIOuj+/lku94dDXU
 1tox906pDKrcYxG/ellkX5EkyFdFzO15GiwFpa0lU0aa/zzHK594lfo75oR3Dcd5txt7
 89+A==
X-Gm-Message-State: AOJu0YwX18JjPMzdGUlfG6teagpTq2L1GhwVk4uDpZUnz0e9jhgTNabz
 rXEMTHAJeXWsDE+wrtXC7lcy6qXfOgIdDhkSToCf8VhLdVKfLHz7u8w/hEmaenoKiEF5grX51+/
 NDVza5/tB/dKtie2YT+bwdljwq+/4tS5U21LYK1iRa7XAx4bkEAa9sk7qYVLMQTUs/ymy
X-Received: by 2002:a2e:3a14:0:b0:2c5:2813:5538 with SMTP id
 h20-20020a2e3a14000000b002c528135538mr1989412lja.21.1697739769313; 
 Thu, 19 Oct 2023 11:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKdWpAM5CyaV7GMfFHvrx7TXwSQ6jRFY+LSHTgBB5pmGR9Qoyeo/ViL8OnlVodkj4qsDvWrA==
X-Received: by 2002:a2e:3a14:0:b0:2c5:2813:5538 with SMTP id
 h20-20020a2e3a14000000b002c528135538mr1989397lja.21.1697739769033; 
 Thu, 19 Oct 2023 11:22:49 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c358c00b00401b242e2e6sm5061714wmq.47.2023.10.19.11.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:48 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Damien Zammit <damien@zamaudio.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 36/78] timer/i8254: Fix one shot PIT mode
Message-ID: <70f86ee9f13bb182d4c4c51d464a4a1c011b3789.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


