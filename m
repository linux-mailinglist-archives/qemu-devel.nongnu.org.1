Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB399814F82
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 19:11:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rECdx-0005DG-Hf; Fri, 15 Dec 2023 13:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rECdv-0005Cx-C5
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 13:10:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rECdt-0007Pp-Oj
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 13:10:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c3f68b69aso9121685e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702663831; x=1703268631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgZx0E2hy0lO0C1EGEqe/F35glxM/6/BetaSZDfCrnY=;
 b=ytZb/nVYQOWMuYrYQhxMfYNJZPo54KKrU1G5Lad5Czzf/bgDzlH72CrDu/rV6AV7Vx
 xpk6Q7TBhPMQpP0YiUvgfwvvlnQjeFOQuRtWsqKTP71xN8GA01rBr2s852csf6LaFBI+
 tovjw7JW503mbFxzgB2g1LKujkzdGucUcxzPQMxQj7wBgO9DDew2GHISuMCiRBS3PjiI
 ypx7mZDxJY4sSgBhQTcX8yahao0Zr1N+r8DbgWEpgRPQN9D1HLOS2Wb59jGcqFjceGjU
 1fP5XB16yPORNAYqGHlVTPiRxdLfSCEG+J9XaX0RPUapyHSSuSXlhOLb000XIyXgtg8c
 k7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702663831; x=1703268631;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgZx0E2hy0lO0C1EGEqe/F35glxM/6/BetaSZDfCrnY=;
 b=Da4xyOn3EOHr9oZ5+I1QeI25id3hM6VCzfSlgFYXFsbAAfguR8X9VdfyfYdLe0RKVa
 G24HVfkBOPiR2Vu79gQI4amnd4PbIvq9nltCmbGIcht7VcewoDOp0isPp+WFDIg8utg+
 oqo4URc+Uudro4zaeGYhYvKxlwtgGcxOiV6KAAkUZbrEXvEzpeOwM9F86RGjXsp1Bf2f
 +vXUVuwO5324Wvjt+Mh2jMYF/eNlHypKmn0KHmZdFCtAlTdkXhXwEVBlRwNO6AAhNVvF
 5iVFN5fKcHKelo5D5skJDIBhswDpdXXCOvlhgZ5BNMsBIoTjiMFKMFqNbcIS1/sMkbik
 xeIQ==
X-Gm-Message-State: AOJu0YyMsK4LeQ3osrGxR1hrFm2W3UlTZTFsssmT6q5TqVsLHNT9kFdD
 EZ5TUNiHv+qjbl0FM3WoYI+skURerfCmwjrglEM=
X-Google-Smtp-Source: AGHT+IG5BwmeoPQE2fbARx5dE7i9fis6v56xdwefnOIQHfS2PeZt8XuwHFfX+eQDNItRoi9O/jj83A==
X-Received: by 2002:a05:600c:198b:b0:40c:5e5f:d3ba with SMTP id
 t11-20020a05600c198b00b0040c5e5fd3bamr2866288wmq.103.1702663830997; 
 Fri, 15 Dec 2023 10:10:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 be9-20020a05600c1e8900b0040596352951sm32520118wmb.5.2023.12.15.10.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 10:10:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64AE45F878;
 Fri, 15 Dec 2023 18:10:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 00/16] tests: enable meson test timeouts to improve
 debuggability
In-Reply-To: <20231215070357.10888-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 15 Dec 2023 08:03:41 +0100")
References: <20231215070357.10888-1-thuth@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Fri, 15 Dec 2023 18:10:30 +0000
Message-ID: <87sf4372w9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> This is a respin of Daniel's series that re-enables the meson test
> runner timeouts. To make sure that we do not get into trouble on
> older systems, I ran all the tests with "make check SPEED=3Dslow -j32"
> on my laptop that has only 16 SMT threads, so each test was running
> quite a bit slower than with a normal "-j$(nproc)" run. I think
> that these timeouts should now work in most cases - if not, we still
> can adjust them easily later.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

