Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3327F8AB7
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 13:24:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6rhA-0001Yi-3T; Sat, 25 Nov 2023 07:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r6rh8-0001Xr-6r
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 07:23:34 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r6rh6-0005LD-Lg
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 07:23:33 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3316d09c645so1694853f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Nov 2023 04:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700915010; x=1701519810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:content-language:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChyqQYn+oAPMzVi6ESY7j+fJ4LKMR9FYB0TtcRj6s/c=;
 b=nhlAKi+31Rg5L8Q8ycyzciOdEj81+Gjw1FctyKd+4Apw5HnCtzvtM/KoNnEvGmh5Lk
 1vvP96/2xGNTk/AigFZfoVJsPA7r1P7lnVaFdb4sKL4DjcoxU7sgLTCvwXiFOPXFmhKH
 1rGM+vMBItEmiKSscR9S14QF9KuFiJU1fMpDCQUzOCy2S2r4ZjqpgxMzQRzpXMHat035
 t7XtzVLfCp9T98DgZ65qAtPrrCHoPaSKZDmiSN557+JvBmzOR8+LGMmpUjG085tdVQ+r
 Zif2ONuEXNOxRmVxcLaVTi3rOVRnhxO1EQzBtx8HqIg781Ye7p4Y8ewnABneSSsfoVmS
 Miwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700915010; x=1701519810;
 h=content-transfer-encoding:cc:to:content-language:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ChyqQYn+oAPMzVi6ESY7j+fJ4LKMR9FYB0TtcRj6s/c=;
 b=Pj2C12N0WdYBgUwv6ui5fqyJgB9vLMoyejati5AtM9/z8omK1HVsB9o7flQhtnwqwB
 MKt9A0xwcSDfH7/G+8n8bczReakgDgWI8gzPxv4Nrhs3defTHK8KaeDG0F9FcwxGCKY1
 McEdGO9gw/Xeg9/bVKQzWb/2ej5Can9B4Bc9dWbS9yPS8U38YimTIoe/V7spPsWDJuzM
 0Pv4iVhfu0PyA4o5W4aw1A3tMObZHUD86tUk7IqZTPCLQG70AwZMFhLq+IZtZfFcC68m
 A+4BMs1Z1cGVL4j8XlQax49DgpG1QB8hhbMJq0e+IcNPzXUJzaDNFBgw6DF+1SpeELCM
 nDLA==
X-Gm-Message-State: AOJu0YxsU7wS1cN0eWKaiGKpgt8IWs1q8rXHgb3KPw5C8JLa0i5U3w70
 9FQpkWavB5xINE5vT+Cqq2POEdxAIEo=
X-Google-Smtp-Source: AGHT+IGx271HdARwHj2gVUQjLIiEXC2QF30wIqhpRph/HQ5fplou3rexQoOsTCqPgKA0vLhR+xLXXg==
X-Received: by 2002:a5d:6152:0:b0:332:e75e:f39a with SMTP id
 y18-20020a5d6152000000b00332e75ef39amr4128418wrt.35.1700915010264; 
 Sat, 25 Nov 2023 04:23:30 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfe70d000000b003316aeb280esm6492357wrm.104.2023.11.25.04.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Nov 2023 04:23:29 -0800 (PST)
Message-ID: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
Date: Sat, 25 Nov 2023 13:23:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Petr Cvek <petrcvekcz@gmail.com>
Subject: [PATCH] qemu/timer: Don't use RDTSC on i486
Content-Language: en-US, cs
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=petrcvekcz@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
The i386 seems to be impossible to distinguish, but i486 can be identified
by checking for undefined __i486__.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
---
 include/qemu/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a366e551f..7baa5d1d41 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -872,7 +872,7 @@ static inline int64_t cpu_get_host_ticks(void)
     return retval;
 }
 
-#elif defined(__i386__)
+#elif defined(__i386__) && !defined(__i486__)
 
 static inline int64_t cpu_get_host_ticks(void)
 {
-- 
2.43.0


