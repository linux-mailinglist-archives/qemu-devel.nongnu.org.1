Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6EA847D14
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Feb 2024 00:15:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW2jY-000569-D0; Fri, 02 Feb 2024 18:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rW2jT-00055a-JQ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 18:14:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rW2jL-0004mj-OE
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 18:14:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40fc6578423so10000805e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706915634; x=1707520434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxJGUXN8FppTGtk7FD0L7PegTie8nFDdTaCS9oM5sEU=;
 b=Ko+5QTbjkhJgCSTWkX744SpHHBv9y3ICyE/LcMLAaTrxQoCJOVmXF0IDN76fjyQMHW
 pAyVM64tbQC+nMvQ65wDn+OcGzUnf/I23yQFgV1ShTtE9cUaPJ5Vkg2760QJTBroBPS6
 9cG2PInTBF/eLq3k5z/2f1P93/GW9HIruhm1ivluSeFbSrMrDr+4/lpHXbUGobsVMNEt
 1e5OeJgoDoG3bR07jA9ie2lqTjrxEwoTbkQu7MZee7t1684NjVzjQ5NpCfalzzoiIhFb
 Gw9SK9LgHtpqnaiAmK1fVPtXiuc/0yejCCeZSeETRD1tL2o5zetv+BMpKmFRxDOjknh5
 iNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706915634; x=1707520434;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dxJGUXN8FppTGtk7FD0L7PegTie8nFDdTaCS9oM5sEU=;
 b=gNSiXSAh2ta/TZCdxGwmPbe0e8epCvmhYayrJq9FqW1fAcLcicNV2Tt1K6eXyrlqdj
 SRoD8x7ylwflz6bB6+pKtMzxqp+78TGPnso0zudDkH2T+azse+gBV5Cpdbr0CGh3sZ3e
 kn9cQ4j91bhbyqRiwnoSnwlRM/2VBTgyz0ioM9INtoqhDzIKjJLcZf7+SDHeUEdhzimJ
 wkOrzUZeIdOtuVMlmUnnJRXw3rVMUXQFYXqauWLpKAus5XMoTNFsnkK3JL9VXfO2gLCy
 87oljLr3Ir2H1W9/+Vlw0yJfFRkkiKZau5S5MUNkP9xzhA8Gjvwxq/LROiDSfvqf20j1
 n5Dw==
X-Gm-Message-State: AOJu0YzlbIU39ndCMYQotayEV+3dNzV5oVmeyT0kNlNw8fawsHbRhh9m
 x75izAs2odOT0Gt5wQ/HOf07ZD4MDLKZD5GZRIHQEHkCdQzRMFafy1mVPDTIgbk=
X-Google-Smtp-Source: AGHT+IGUUqJ83BDiw6JyY9T/I1HN83VB07n3NtbSV+9L5O325FvaiX2M6ZO2pJqJ+ECfnmEARwRcMQ==
X-Received: by 2002:a05:600c:3b0d:b0:40e:b0fd:3c09 with SMTP id
 m13-20020a05600c3b0d00b0040eb0fd3c09mr7405028wms.9.1706915633630; 
 Fri, 02 Feb 2024 15:13:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCULU1asxItoY+y20Ur2cArcuPSd+kBWuIcgYnDJ3uXnRLgc1DfE9/8sE9iYA2x9+w1z92U5u9IoCT5my0W1tEZGMzwJSGvkuo2w31QP858felsgCRUjups4
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b0033b1b01e4fcsm2819311wrq.96.2024.02.02.15.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 15:13:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E80A65F7A3;
 Fri,  2 Feb 2024 23:13:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] gdbstub: Implement catching syscalls
In-Reply-To: <20240202152506.279476-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 2 Feb 2024 16:23:42 +0100")
References: <20240202152506.279476-1-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 02 Feb 2024 23:13:52 +0000
Message-ID: <87h6iqpihb.fsf@draig.linaro.org>
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> v2: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02980.html
> v2 -> v3: Simplify the catchpoint state by making "don't catch" a
>           subset of "catch some".
>           Factor out several prep patches;
>           Don't use snprintf;
>           Add some comments (Alex).
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02911.html
> v1 -> v2: Avoid touching the system gdbstub.
>           Advertise QCatchSyscalls+ only on Linux.
>
> Hi,
>
> I noticed that GDB's "catch syscall" does not work with qemu-user.
> This series adds the missing bits in [1/2] and a test in [2/2].
> I'm basing this on my other series, since it contains useful gdbstub
> test refactorings.

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

