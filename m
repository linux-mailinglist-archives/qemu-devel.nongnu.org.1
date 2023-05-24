Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E95D70F432
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1liR-0007gv-70; Wed, 24 May 2023 06:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1liP-0007eE-Ag
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:27:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1liJ-0000Mi-Pb
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:27:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30aa76048fbso417472f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684924046; x=1687516046;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpTGeSOyMR278ayE4wJVueiGM9S9Umkw1u4DCgJP2bE=;
 b=QxHNNbJf2I5XNxjvBEL7Z+E3W7A6Os/SJBC8hNmWLxvw3fZhHapg+hg67OeVVffPgb
 IcsMoWV/2ObiIUa69RLbCL3160XkKeKwWFz0MLJ212s0AtaMCnmkky843fWrU3IwBvuC
 7UP/s/hqWT9AHcJbpYkFSAXRaIFwL4tr0qBUQVWCZJX3Jv82JpPYmzHCvARzSHGd+VXL
 NnnXCb31lwrxYOFEusZlVzbqf2Wz8Yq+DmVoSsCTTE2EKSd+I9dfCPBlEvv44fx4U5Cc
 YRPRmhNC1xryHDmD7ci8pWQs08RbzdBhB15StVXr8TGfP70u8Q0XGlNDg8jhbxrCr5HM
 EhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684924046; x=1687516046;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CpTGeSOyMR278ayE4wJVueiGM9S9Umkw1u4DCgJP2bE=;
 b=ATtW3nxrGi+2tHGftWFyhcu46XwuaVa4sdM+BzAbqfxoiDsAfstN0zu+NAluz3kS4F
 as8vV8lPXWbjcf7CCmeiz9SJPnL/iGsBEAiiIaLoFUUcPwxg64IafJavlfmPE8U5cW1+
 +cpoLfZ6EAym6H8aMjsFGGKOSrCFkEiFHNHi3WLZlYvGwQkBrSmP6uIx2jBrGbvHZALO
 ex5Zah/fXu01bhmWlWMsRidy4ICOcpdr7bnVXjJMqnQa9P7ysQoTnhhQHztfuwWeW7Wv
 uf87fKytWXeWhqtOXSgZoMHtl7JxWzCEq4DTDbxK8qzj7qK1Nb2Ncj3j7SdQlsU6/S0z
 04xA==
X-Gm-Message-State: AC+VfDxDLR+fV2lWpnUzu87ELeCjFJZHdGgEWUcPkoS+LPzvQMVSl6he
 bzeYqDvLArdFqigRzEa4a6N6xQ==
X-Google-Smtp-Source: ACHHUZ5wiYsmfyNLTWlzhRfisSUHaL96I58DdqhsSimCOS9rXkqZbW2XIFjoxce7nqU/xZf50VNotw==
X-Received: by 2002:adf:e445:0:b0:2f6:a8dd:f088 with SMTP id
 t5-20020adfe445000000b002f6a8ddf088mr12855001wrm.62.1684924046206; 
 Wed, 24 May 2023 03:27:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q3-20020adff783000000b002e61e002943sm13899008wrp.116.2023.05.24.03.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 03:27:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E0D91FFBB;
 Wed, 24 May 2023 11:27:25 +0100 (BST)
References: <20230510202654.225689-1-iii@linux.ibm.com>
 <20230510202654.225689-6-iii@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Dominik 'Disconnect3d' Czarnota
 <dominik.b.czarnota@gmail.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Andreas Arnez <arnez@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND 5/6] docs: Document security implications of
 debugging
Date: Wed, 24 May 2023 11:27:21 +0100
In-reply-to: <20230510202654.225689-6-iii@linux.ibm.com>
Message-ID: <87sfbmvxbm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> Now that the GDB stub implements reading host files, concerns may arise
> that it undermines security. Document the status quo, which is that the
> users are already responsible for securing the GDB connection
> themselves.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

