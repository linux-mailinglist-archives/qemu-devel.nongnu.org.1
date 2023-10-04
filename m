Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E27B7EE5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0oj-0004Tb-QX; Wed, 04 Oct 2023 08:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qo0oR-0004Ns-RP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:17:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qo0oP-0001kA-5J
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:17:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406618d0992so20184865e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696421826; x=1697026626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQM8ItS9sidPVajC5kJZh6qyKQL0U/waR4fFVUzaQy0=;
 b=jTg4NeOJAcXIaVSOqvKz3f5BW06jELKjdc9KIO4Hlrq4JBZ4GkpVlprFqBn1w/5dZi
 9BxMOdMFOP3zca2aRYREnk5e+Lz6+PhDID+j7RnLUyGy8UX73Vu73vUjhoJisNUUTQBN
 yGM60cWBtnlpsVQkMCLUDTRfbIdqJDkdx7U1AKZsuCBICixueIFCIrlxCpTMq9tzY2b/
 S7gPo28gda6P2Xqe9Z3KW+8XbPr2p9Vg3gfeO+zSFq2SuGFrJUU3ArYIMU7dcEL+KQUx
 wkv1eXKHmpi5RDLJZEvAN6R07xsZE9pWMSdveD0md21Z+2aAF3dK7rxsgk5DNpZuhJ5r
 vPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696421826; x=1697026626;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QQM8ItS9sidPVajC5kJZh6qyKQL0U/waR4fFVUzaQy0=;
 b=UNKi1mVqKvNiBfHrAS/OxjJ6Wd1b+clA0QK30yIkYcImBCYF+Xhra0LiW5cU6d4Rfx
 SmKmmbdNN0TXcuLO8r9kvq8dIeSS+DWYGjL2Z3aMmMV8+M4JU8vquBD5uw+1JuSibZ0C
 5fzwVXhAdZwki3wYiqRM3Qr1W2cz5wxPU5jCk1awyo4dKFsz5kWyD7Gvqtp+hUf6A1f0
 LxwEd9QLcz/SiGU3+buvXB/C/8bV+bxmEkVFqzp2WwTIXqadj0B8pZvM88xR1TH0K4pw
 mZTG1egjprYJIAgQ0r321gxBRrr4u271+67d4winn6+L6KUI8H2H4dBnyjQf6RCjRCmY
 KbBg==
X-Gm-Message-State: AOJu0YwJ5S/AurpeLRd99pt1KJMI9GWw+Ba4al6nqlRjqvRZ/ip7GMUq
 YdNa4qc0m1eYIDC8sUsc3cLHyg==
X-Google-Smtp-Source: AGHT+IGZdR5v7uuWwRJo0rVo5X7dqV33qRbolZ3m0G4ssHXJWLuMqgcPREgDcabIEvMz0qqlux8L3A==
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id
 u9-20020a05600c00c900b004064d8f9feemr2161713wmm.24.1696421825958; 
 Wed, 04 Oct 2023 05:17:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a1c790f000000b00404719b05b5sm1369810wme.27.2023.10.04.05.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:17:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3A7A1FFBB;
 Wed,  4 Oct 2023 13:17:04 +0100 (BST)
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-10-philmd@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 09/16] semihosting: Clean up global variable shadowing
Date: Wed, 04 Oct 2023 13:16:36 +0100
In-reply-to: <20231004120019.93101-10-philmd@linaro.org>
Message-ID: <87lecih9a7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Fix:
>
>   semihosting/config.c:134:49: error: declaration shadows a variable in t=
he global scope [-Werror,-Wshadow]
>   int qemu_semihosting_config_options(const char *optarg)
>                                                   ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.=
h:77:14: note: previous declaration is here
>   extern char *optarg;                    /* getopt(3) external
>   variables */

I'm going to assume the getopt.h is somehow swept up by osdep.h?

Anyway:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

