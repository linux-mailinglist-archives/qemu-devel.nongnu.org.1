Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F01937E41D8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0M-0004WG-0H; Tue, 07 Nov 2023 09:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N06-0004Ja-B5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:20 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N02-0007d0-8h
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:17 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so82244441fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367051; x=1699971851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fx8qgNA+lURQSXrzmxWGQIf9pj+8j0bs83issrteW0E=;
 b=PLOoO8eGhOlFKeumePDkiAtGvx3GOqJZA3P4Rg1LR7WcCmx2wURDxeoCO9ODqzpGyr
 BM2hfsuLx9ZFNnBIU/ghk5KSglivsJLZhzDm5TveQkw38FEFgtEV43QcQSGdAklc3W21
 PTxtvulzPsaNbPtk5TpeXUHKqtOK+R3mDqKbvSfcnb7d9VGObkB4wyZhsa0Khjyljefg
 5sR3VRPoJAcIhSS7RNiDC0ovh4Ckfl+k+BpMG5smxLhekTvNIc26ZesBwuYVhqL5jOLN
 iS1sdriLAqZW4LXUglrIEsi/Lsx02wX8gYXxi3YvCHM4SXVElEizCMnaOoWqbAykBs0e
 G6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367051; x=1699971851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fx8qgNA+lURQSXrzmxWGQIf9pj+8j0bs83issrteW0E=;
 b=Q+r90JEKix337C9ucaaIXKGoII6SBTQCfHKHau5+cjxNiX0cdfFpB0mqI5nNP4UgY0
 LZGy63KntKhIHqwMVtuJzSFqlRhbQfwP4PBp7/m+7qEZnx521ix0ieOB94PWE2R5OYEf
 zYcq/6o9CTliNh+2IAlzgsdd6ffq8wASmm1FHFzDAXy3eXTEjueUpWHqh2WSJp6Q+fgk
 ogmHUM37fj7368lA3lEwfCDgdc6kqSUm8s/BBYzFwMmNkA0XlVnnwCMkGrsYEckO9quV
 RNl47de3JMuZs8MmRQWVX0yTDKnouuYzJYNBXLnd113V6L9g7eJLJ7LyCkPaof588M7N
 3AcQ==
X-Gm-Message-State: AOJu0Yy8oBFsJ5HkKFyM+10oZ21+gDCi4Ru8IwF0d/xLXTZdL6RtN1Hk
 P52gIrC7AdsFq4uBi71+xYT6VsPh0wUWTJbc65K7yg==
X-Google-Smtp-Source: AGHT+IGMG8hYPvrpeVVfMGUBP5YM0s3bPz/SgC+agjmDwxWGdg991PMqEXvIqdu/AIWJ9endt9mh+Q==
X-Received: by 2002:a2e:a7c3:0:b0:2c0:33be:3530 with SMTP id
 x3-20020a2ea7c3000000b002c033be3530mr22935397ljp.45.1699367051494; 
 Tue, 07 Nov 2023 06:24:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ew3-20020a05600c808300b004054dcbf92asm15362371wmb.20.2023.11.07.06.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8CD6E6576C;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Timoth=C3=A9e=20Cocault?= <timothee.cocault@gmail.com>,
 fanwenjie <fanwj@mail.ustc.edu.cn>
Subject: [PULL 22/23] mailmap: fixup some more corrupted author fields
Date: Tue,  7 Nov 2023 14:23:53 +0000
Message-Id: <20231107142354.3151266-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Timothée Cocault <timothee.cocault@gmail.com>
Cc: fanwenjie <fanwj@mail.ustc.edu.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-22-alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index 94f19a0ac9..e12e19f691 100644
--- a/.mailmap
+++ b/.mailmap
@@ -30,10 +30,12 @@ malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 # Corrupted Author fields
 Aaron Larson <alarson@ddci.com> alarson@ddci.com
 Andreas Färber <andreas.faerber@web.de> Andreas Färber <andreas.faerber>
+fanwenjie <fanwj@mail.ustc.edu.cn> fanwj@mail.ustc.edu.cn <fanwj@mail.ustc.edu.cn>
 Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
 Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
+Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
-- 
2.39.2


