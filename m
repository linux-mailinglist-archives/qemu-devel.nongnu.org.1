Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B792831AE8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:55:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSrD-0005U1-63; Thu, 18 Jan 2024 08:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQSr7-0005Tn-58
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 08:54:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQSqy-0001Fa-GL
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 08:54:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso47681295e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705586080; x=1706190880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pnWvOCbizk4wDZBdjGnjjs2jJIHTbpG5y0aOsVUVv2w=;
 b=jPJIOP/uYYUtwdtBVtgymcaWB3aO4w5QmKK+BW6sRgnF8CT06D4YtK5vQSEuGK4oRs
 otFT73ZzfC5S/5eu9Q7DraZX4ivrGw5Pz1bHShzDDghHHxqP5s8UR8Ra8LGYW9zF38hX
 WvR35jgZFsYhuFekioTJbqYMq5IGX0ZZa8yPcN46gAQBpQ/RK9M76FGwxlM8/DFEdBkn
 mac0xXEV519A3ogJADSGnlRrXzbfD9pcSWxeGT8586F8QSM4IvUO/ZV1V+542Gi1a/Nn
 f9ej76XPy5tDsfrVprepWkUYMSGkmL3FhhaNo/cr6/45uvOGZE5GDhmzJQrF+dEPB8ls
 Ee/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586080; x=1706190880;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnWvOCbizk4wDZBdjGnjjs2jJIHTbpG5y0aOsVUVv2w=;
 b=Qi+Bcll1xUs2KOahcW9MnTZQ3XwS72GAIapEzpWoqxPDn4lPGlrmYsPsX0iIioZ3zk
 Swghe/KzsIhjmz9XJRPsUKPZYbgxahwmU4r002E5qB1Y5VV0JlMKkbBKUznTm7aojogT
 EI7u+AyGv+MvUz6W3qT4w6VB1GXk5Mtfs01v7xACFWHsIIWqY87+US9A9k8bIwPlsA6N
 IZppXD7MIuOelwNiVrXbA+4YpLcYxeMZ+WsP6krnQqhTP6d30T0xLdoSjG6z9H5cYFo5
 nxMxTV4XYkvz744c03QTFbGnsQHaqFtySBNc1NAVBvIDnHhKKpBJNWdcUDZXhmL68/6U
 RxUA==
X-Gm-Message-State: AOJu0YxNrAYz5mybC0ZiStB650CvRxJDisD42O+0zDq6Ty19LpOsb0Pa
 cIGSKFfGyNo8gnfYqbPeeMGojfO/sSyxSoF01+RyR3PPH9FQv/pUzjdcf60hlWhcFCOYr4lrA1V
 b
X-Google-Smtp-Source: AGHT+IGZYJE1SG/wUYVLhlI3QQwaIuLUONJoAKKrdMMPADHsuSSa1OAnTUcd2q2lPc/Dbt7FQhV9iA==
X-Received: by 2002:a05:600c:3648:b0:40e:692b:1b02 with SMTP id
 y8-20020a05600c364800b0040e692b1b02mr246705wmq.78.1705586079742; 
 Thu, 18 Jan 2024 05:54:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v4-20020a05600c470400b0040e45799541sm29651609wmo.15.2024.01.18.05.54.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:54:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E80B75F8B4
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 13:54:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: KVM/QEMU Community Call 23rd Jan Agenda Items
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 18 Jan 2024 13:54:38 +0000
Message-ID: <877ck6hhlt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
  23/1/2024 14:00 UTC

If anyone has any agenda items please reply to this thread.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

