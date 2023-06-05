Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB625722C1B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Cfi-0008Vw-7o; Mon, 05 Jun 2023 12:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CfP-0008JK-Qf
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:02:51 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CfB-00052I-DT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:02:47 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5149390b20aso7637662a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685980951; x=1688572951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JAtbcSNKgU0t2U2g6dUjEkJrGmtNP72vjyAOFMxEUk=;
 b=kWQuS2ut2JoAUrRwJ/ny6QPR2nzrLpgGxsFtgxR5uufjaQMyB+/yqc97I2bigVzHFS
 x+bB9FHtsczn8Qg7lxfhdYpQQrX2o3elDZ+MCHDDj1XTgQ+4CkKBM2BoibHom4zNZPy/
 3RmIzXTpbwJt354B+GsP2LZze1lsvGwIOV1Ms7r88P9HxgEo5HwAA9za+a/khUQopBC3
 mszQHL0ICyGYI6EROhOWHfUfEoCjYO/m+zdVBnSBq2N8qFUA/cOyhyXFCMLlGk0C4gwN
 /MRK/HqVL7MuLxd/GGp2sYQlG73ECMhoargPQQBtyWvcPT8xFwfIFtKG3TB+av5Gi/rK
 fkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685980951; x=1688572951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1JAtbcSNKgU0t2U2g6dUjEkJrGmtNP72vjyAOFMxEUk=;
 b=gBFwcpPxj5Hm12h7NSbbui3VgfC1t3T2QvjczzInBVIGn6g9vEssvWG9BEKuvpoTmO
 YMWtUqFLCesTeJSR5ohK7+zm9ByWgsC9DGKDT8R4pDuQKJ0CJ//8xZkpjMH977loP22b
 DVXYYLvkGt2x82xu8r7HXt9Nl7C2iZRr1Pn9vyjd6W7VX8N2gJilo4AF0fAMze5j1Kj6
 ZFsegDvrKukwe2Tyha5vmXRGRbUhmX8vadFyAjFApxWyU1oEWJHA7pTisd26GnlHm7Lu
 H89fEQkzvj0qh/VDiCYw7UuSQtfCz8F3KRYBKgTh1STJZ/afbpXiafj9Cll5x+9tkvaa
 +f4Q==
X-Gm-Message-State: AC+VfDx2tiAqwojYmQG2yKKw9AZ+J3MQjgvLEwXwVKQggapAfVvt9kjx
 VQK9lAbQ2uo1tcfcOrU4HU9kg8V9Ewpb9tBvl3HJNw==
X-Google-Smtp-Source: ACHHUZ62LfKh0yO7M3pQSA14tG/byKaTFV9+1SRDCDbhwPiyv1d1WQEMBYyVI+z/h1kvEnHt0REDb9HMHTEJm+vuHlw=
X-Received: by 2002:aa7:c650:0:b0:516:4098:66f4 with SMTP id
 z16-20020aa7c650000000b00516409866f4mr6330914edr.18.1685980950963; Mon, 05
 Jun 2023 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 17:01:57 +0100
Message-ID: <CAFEAcA-rjY2LGn7fW4d2Cn4J-7pURQPVdrXmt+bn+623Coah=Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] target/arm: allow DC CVA[D]P in user mode emulation
To: Zhuojia Shen <chaosdefinition@hotmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 1 Jun 2023 at 23:09, Zhuojia Shen <chaosdefinition@hotmail.com> wrote:
>
> This patch series enables executing DC CVAP and DC CVADP instructions in
> AArch64 Linux user mode emulation and adds proper TCG tests.



Applied to target-arm.next, thanks.

-- PMM

