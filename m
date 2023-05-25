Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1B710D91
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BKR-0002sJ-Oi; Thu, 25 May 2023 09:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2BKQ-0002sA-BV
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:48:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2BKO-0001iu-8M
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:48:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so5459865e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685022506; x=1687614506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=Feo5j9kg9nzHqutBOzUYvDRhbe8AD3D83/N84q/prNk=;
 b=nLYzLaitNPHjyabcRDARg7pJ9UQDqjskPd/od1qzW7S5gEfETQ0V6brpc9eaiII/f2
 ShbYuGbX6lIyGZT8G/sfORvm8VrUxsCNbKCAVz0TQuQLcgh3s1j2gV7a/iEFKfj0hm70
 E0FP/dlUiZ0u8gkBJw3SpPs+8t0Kko5JVC2dRwnW0yrAUBHg58i9YArdMecW/0yVLPVj
 cPOjGd9hc5V1vq6UIN23ktHA0lmeAOXa4jVOFbpGPS8kCzb2W+CqsI2BUN7j5BUqNawQ
 FxeLnczx6IW/y9Ouaig5GNv9lCdvVvefob2506ySjW+tGSdXQuHvyvcmsZcghN9kia3m
 nYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685022506; x=1687614506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Feo5j9kg9nzHqutBOzUYvDRhbe8AD3D83/N84q/prNk=;
 b=NT9OdsKAHFtDiQtWLdkk2VTRK4CvvbgfGqPChPspFGtwUA8mjhtg+gXtwFGNMQNzmD
 +nm7GeEpQs/WXqljHBh/JnfVbHbTNmcJGcyrSUt75/nrtgEq8AWOkD8kQfkvDkF82eE0
 aJF0ra0zJLvJfsvTqllQSHh5Ov4YmNRvH0rgfN5CCeSSblXcb0Rnri0f8gfXPyLOmpYx
 icogXl93YhmoK0414N0bDkv4lIbOb5DzTQWFv0V+Zf8QB2u+cGt0DFlyBYGnPqLSgizN
 L0DXIhcNiImJdxZcSr8RtKPvdRMb/4rGTdI5SWVpoSAAn4KtTWwEEGH1W1Bmj04WTK3c
 14rQ==
X-Gm-Message-State: AC+VfDwqL1vDL6kL656pI2IjsOrYCw7a4dWwn7/6UhwxhomezeAlbDa5
 PckSJcRZ11FWZvTplQmPa8ZfYw==
X-Google-Smtp-Source: ACHHUZ5D8EM/Pvxk9riq6HNiVxwvrfNiMzi860rbDhzE5JAUwdGpSb0R0Y2fJ0JkUaPZu4E6N65Q7w==
X-Received: by 2002:a05:600c:22d6:b0:3f0:9564:f4f6 with SMTP id
 22-20020a05600c22d600b003f09564f4f6mr2304843wmg.1.1685022506534; 
 Thu, 25 May 2023 06:48:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c24cd00b003f4dde07956sm5761720wmu.42.2023.05.25.06.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:48:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7ADB51FFBB;
 Thu, 25 May 2023 14:48:25 +0100 (BST)
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: QEMU Developer Survey for KVM Forum 2023
Date: Thu, 25 May 2023 14:41:46 +0100
Message-ID: <87a5xsttcm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi All,

It is that time of year again when approaching KVM Forum I like to
gather some data about the developer community. The questions are mostly
the familiar ones although I've added two new questions at the end.

If you are a maintainer or developer who works with QEMU please take
some time to fill it in. It should only take a few minutes:

  https://forms.gle/xb322eKH5bXJc4uj6

Thanks in advance for your time,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

