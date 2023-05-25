Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00386710D47
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B3A-000661-G6; Thu, 25 May 2023 09:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2B38-00065O-8w
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2B35-0005kB-PX
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30950eecc1eso2097353f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685021434; x=1687613434;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXDgwzyyaFh7VmL/7FyXrnN2HULEQF4IdhSUPXRchZA=;
 b=moxAYkTnQOzrebyzENm7bv/qC9A845mzOnVOPcyf5YP0cIcynVS/sEJR/3cudM9BBg
 aKU/gWaN4yMPOFnlab9ep3YWOpjm8bPMZc55klB2y3puIW1ZueqTUV4Q09v0SBU2k/HC
 bfk1LnG+sw2XiWKyYtstkHBALAhCP4MfFX7t8redTNHVg9Kwj9vST9FtYBN+tEgUf+Ja
 B4Z3F/u8l2cSwbaPEx32zYMgwiWMp5P0pS7K5dx0Z48p2OlgnyluHEZJz3MTD+oZfUAi
 u2Xyb3Fv5JQRBMdl1xamnBAtEvNrFgH0ygu9OyWiaf0Waf56hNjizcOrmRncB0LN73s7
 A+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685021434; x=1687613434;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DXDgwzyyaFh7VmL/7FyXrnN2HULEQF4IdhSUPXRchZA=;
 b=hUyWUY1n8AcZtPLtuBpjYY18j4cx1XDUZ9igY9D7bEz28Bn6n+cmKqakKkkVSVvR0l
 IKmJS/kUSOWL0QU4JlvXcXX+Aj9ZRiLWpN5tXzliaRsbf9PjOWX6kAK2UE6PQJ+a/yJl
 8Suy9A/VQwDDIy00Qh46wgqaWHdTLsapaMnYMzh1N4wN5V9mqXSdXfFasN1VwkM9H88F
 PTvX0g5XHe7Oopwo76Q9j4N+CujvqlrSn1wfc3ec+A6W3O6L5fWbenS9rOKMXC86zLMl
 sERi2hKo38/EkzMGSLUTYBQ032omkFGNW76MCFUF9fHy+d4Rn6sIhFXdY4QPfGFfrxIT
 qtXw==
X-Gm-Message-State: AC+VfDw/JhmgUj8JgGPo8KoXTZEl15L97X0gpMhAsxaCfVmdEfrFrk/H
 WteJD/X0nldpygsOvgNxm48Wk5s9m7ZaVVLbgKHBNA==
X-Google-Smtp-Source: ACHHUZ4VXpcn/Q8J8CzhtyZ72Cyu7PXZ+jQqzcvk8z9JEVReReX3pIfj3vJUoA1Wz/uiyJenJRlSXg==
X-Received: by 2002:adf:e3ca:0:b0:306:45c0:f070 with SMTP id
 k10-20020adfe3ca000000b0030645c0f070mr2598806wrm.39.1685021434049; 
 Thu, 25 May 2023 06:30:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i15-20020adffdcf000000b003021288a56dsm1789896wrs.115.2023.05.25.06.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:30:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 150F71FFBB;
 Thu, 25 May 2023 14:30:33 +0100 (BST)
References: <20230525102844.209240-1-pbonzini@redhat.com>
 <20230525102844.209240-4-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH 3/3] Makefile: remove $(TESTS_PYTHON)
Date: Thu, 25 May 2023 14:30:29 +0100
In-reply-to: <20230525102844.209240-4-pbonzini@redhat.com>
Message-ID: <87r0r4tu6e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> It is now the same as $(PYTHON), since the latter always points at pyvenv=
/bin/python3.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

