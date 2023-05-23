Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123B70DD86
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:34:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S9e-00076U-Ul; Tue, 23 May 2023 09:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S9b-00076J-7Z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:34:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S9Y-0006Ua-54
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:34:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3093d10442aso4763952f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848853; x=1687440853;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvpu4YnJvF/dk8J3IzU8Sbt+9ArGhkJie3b4GF1c3d0=;
 b=ZcosV15VNPzZPofZFgwLrK53QomCdUPn09Evria9L6hnhaSPWhWJfXKTReMb9E/mg+
 rsTVl0dDrueFuyAxs3H7q3okgj92t7FlDzGddJtiOWSLLEiQi+tILWHilO0F4UYrg95k
 pWB5P6Vp8hdCnW1kMDPvt9bBsdoi7/dPyGyk5v7xsdEGcrWiVbiwBgx2KSSk3e68QW8K
 oAeel3cieJ6UppN1xQZJ87L7UWUGElTZYD1DurhWg9yEYjVaLBqZ7lFVELoN0QAmloph
 Mje8RqPkpf38+eGtEvIdeEpqMvZ78RvusTIN4FWpn7n6zpLCounhuL2GDJMoph3KiSNJ
 eqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848853; x=1687440853;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rvpu4YnJvF/dk8J3IzU8Sbt+9ArGhkJie3b4GF1c3d0=;
 b=MGg0gwk/4aNFQMKhnuL5G6Daqw5+d3ICdUujkdOiw5JVmcE0QBALYMdXBUUUMXUe4E
 e2a6FJ4hT3BtYEVdxXRx5bA/mHQFGL8/YY1HvYlpL4NSpNr7qha9d2MOVGGSaXXmC238
 2eW4DzcOhdo1vzaj+3o7jyJ7KEwIVkC7zJzqNb0dYW4SQbOcc99iegDmXZfqnPTqnovg
 bAiS25r+W//KqIFZUcljtoSJYHCe6Flw7VSUePff52PgM/QAJc5m5ERT6z+P+jAIhfYp
 sgLRzGjL5qNXXYOfspCW0orgdyeLXyZwjaNGA61hR+ufbZewLpyDmX8syPqIK9HQl8s/
 bVeg==
X-Gm-Message-State: AC+VfDz+Ecr4DVXSPFDgF02SWFSYLAuiqyyZJOWe2QGmgPCE8kGI/vu9
 LBO9dzmyoXWKlA+aVHV33NpVOQ==
X-Google-Smtp-Source: ACHHUZ5a3jeQt5NUTRviCFzMNgR5Via3N7R4gMKzQYSEdwgvEbjtqLVHbDNGK84H3BhqJA4lPrrVXw==
X-Received: by 2002:adf:e8ce:0:b0:309:50e7:7d0 with SMTP id
 k14-20020adfe8ce000000b0030950e707d0mr9563675wrn.31.1684848853262; 
 Tue, 23 May 2023 06:34:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a05600012c100b0030630de6fbdsm11069259wrx.13.2023.05.23.06.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:34:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 675E91FFBB;
 Tue, 23 May 2023 14:34:12 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-7-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 06/12] hw/char/pl011: Replace magic values by register
 field definitions
Date: Tue, 23 May 2023 14:34:08 +0100
In-reply-to: <20230522153144.30610-7-philmd@linaro.org>
Message-ID: <87ttw341ez.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> 0x400 is Data Register Break Error (DR_BE),
> 0x10 is Line Control Register Fifo Enabled (LCR_FEN)
> and 0x1 is Send Break (LCR_BRK).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

