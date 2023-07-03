Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008117459E1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGXw-0006Lc-Ks; Mon, 03 Jul 2023 06:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGGXU-0005sm-5T
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:12:12 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGGXQ-00089S-R0
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:12:10 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so6555761e87.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688379127; x=1690971127;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2Z2kT5w0Gwp8ge4TO1Tlz3y3sTvQeH+TSjFeYOvZAw=;
 b=NKrVr+hMRjlEngoKuOMQtLuptYaf+/bdOHkIfyl/3ALszn39/Denr6n/2dJi54Whya
 JMNm5rUwPbvuaDu3wlZcsWFUJZOrRUHXYvhTj2gQDbLSCAMWD+pY1G/tawEuc3GoIU7F
 /gyzRHIAXL7wJNxA/W63m4ULbLX3o9PoE7Z4oYAl2zj4afQeT+XZB5LoYkCX7fqq4yAm
 G4/70UWfBOn9LpJaPvDp3BOkn4o2kAaPj4bZ+GCg2+cxQOpSZ6TO0T8EvWG7DuAW5lpu
 YF6fIgAuIy+IixZ1vLbk7pBSy352jjzyelqQc/vnLucF9DVLbE7JfkgcCqJJGjoznB94
 vAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688379127; x=1690971127;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q2Z2kT5w0Gwp8ge4TO1Tlz3y3sTvQeH+TSjFeYOvZAw=;
 b=fcrkBwvRwhe4TAOIEQ/cFa7tQLPyNcSRWXaKCNwt5Aj2yYashAXFIVBhao2aHkafiZ
 asYJeB8DAUxY9M8JdbviT7TYobx7lRaY9BSFQI+qrQjg8iG2YXRJaX6KwQoUBVBvOIrV
 k2GXnD6evzeLZQCrveb6mT6hfLeTQ9PMjpuu+WdankuR1AA0Jt+n+v2bQ9I94VmVf9hG
 E7ma52JK61Y0OvWEHslvy/YsHbS+BzBvpr6rQJK41mNggqjCBVasM6rR87SEZBzNmZzN
 6U6416nefXRn7+rijcazsil7uotGD1K2bMqD+axVOowgzhNxN8yjkN90Jhi/Lv/T9RzY
 R5cA==
X-Gm-Message-State: ABy/qLbV5VWD0j7Mqxff5YI8mjSgXtfaeAqn85VhzAll2ShS8TU13c/3
 wIjxvUgvlDIR6CFoO9ktftZTBg==
X-Google-Smtp-Source: APBJJlFdIjw2boUyLDYkEiPvpjHV63JA3zpxXpFiKRvrL6TO+tTCwmTGLqCc2Uk9Mta33E5FO2/6dw==
X-Received: by 2002:a19:8c1d:0:b0:4f8:7556:23e6 with SMTP id
 o29-20020a198c1d000000b004f8755623e6mr6055506lfd.54.1688379126886; 
 Mon, 03 Jul 2023 03:12:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fbb618f7adsm12361802wml.15.2023.07.03.03.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:12:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B6571FFBB;
 Mon,  3 Jul 2023 11:12:06 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-11-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 10/24] linux-user: Split out target_to_host_prot
Date: Mon, 03 Jul 2023 11:12:01 +0100
In-reply-to: <20230630132159.376995-11-richard.henderson@linaro.org>
Message-ID: <87ttuli9s9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Split out from validate_prot_to_pageflags, as there is not
> one single host_prot for the entire range.  We need to adjust
> prot for every host page that overlaps multiple guest pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

