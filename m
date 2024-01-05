Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83D825A35
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 19:34:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLp01-0007mO-BF; Fri, 05 Jan 2024 13:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLozu-0007lq-RE
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:32:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLozs-0004Cq-MY
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:32:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5f402571so20775565e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 10:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704479561; x=1705084361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7xvXBwo87761ZVxQHWaFVWLnITZo/3LXTjKwSv0DQj4=;
 b=gOcTX1hqVrHysfw+IVEFcmwvRSz5ddciruhA/vcSerD7IG6wwwKubI4oDtEZTWkWlL
 RBepEnTiuQsZJZmcxd8C0wnHMvhTrBrfi18fBwo828ccku5SVp0zuxq6VIst42g+8Jix
 bsrH1luOZWbqRpYhaCkAMIX5Q/bjpNZHPnFv/GBlzSXbiCfBMb0i69ywnzvGcJUvmtLz
 ePWm/SqfFhLeXY/s6fHJsLglaSmk5NFQbrDbhE6SHSp/DUH+mqRwtUp6mBcleGcJW9/j
 C4XuVGrSJTY8n/68XV97dqlba7a5YcHpJUVDYHmAU/zXHuiInByioN2sUMjdP4+fVspR
 5EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704479561; x=1705084361;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xvXBwo87761ZVxQHWaFVWLnITZo/3LXTjKwSv0DQj4=;
 b=YFcz3BmTOvkLA3fThEy5+XWW+sF1mAriYJIwojcSQG7YGTG5sx3lgBMwp9LTdefelm
 j0Jd92fX6Rztn02OmRVo50Ck5XVaecbFU0MEniBtAq0mQfUEoxUpSRv1j23q7Tz1BOLL
 3+77oag+B/kaFgp/8kZA52027r9BxLNbtEx/cKg/RrmkU8utkq49VR9vj9dTBoFzyj5K
 G2sPJa5P8MVhXq36j8aImdh78tvXzZlNZVr+hLaQUx+qF31kUyS1Im4QekjvjkqivNpR
 NoyqKQ9igWfnd7OI/gZlk0iY7osGVVHM1AkmixzXIx7BAOAiJHRKbmiWqbLHImAWYSuX
 oKpg==
X-Gm-Message-State: AOJu0YyqcQJvVYzxuyxStAPLz3GeIy21Qu6rgomXooRPFDz2hX62e3Nh
 VHfU6EWAW6VLPGsNprZ8+j5ODK1o5qs0kUBjaGUymBUjur4=
X-Google-Smtp-Source: AGHT+IF9ANEaml3IkJZmbG7X8zNqFiXTQlvXBpXmmnsm1BLUn/gH+fEGY4fllUhDcfI2DSgeFDlcKw==
X-Received: by 2002:a7b:cb9a:0:b0:40d:8815:bcc6 with SMTP id
 m26-20020a7bcb9a000000b0040d8815bcc6mr1170445wmi.12.1704479561230; 
 Fri, 05 Jan 2024 10:32:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d1-20020adfa341000000b0033662fb321esm1865014wrb.33.2024.01.05.10.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 10:32:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 929675F933
 for <qemu-devel@nongnu.org>; Fri,  5 Jan 2024 18:32:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: KVM/QEMU Community Call 9th Jan Agenda Items
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 18:32:40 +0000
Message-ID: <87le93eilz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

The KVM/QEMU community call is at:

  https://meet.jit.si/kvmcallmeeting
  @
  9/1/2024 14:00 UTC

If anyone has any agenda items please reply to this thread.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

