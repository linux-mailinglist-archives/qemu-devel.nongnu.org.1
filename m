Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6970F9C3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q4m-0005Vh-7P; Wed, 24 May 2023 11:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q4h-0005Ip-0P
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:06:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q4c-0000cH-6z
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:06:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30aa76048fbso687887f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940804; x=1687532804;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJmgLNaYT6y642AgOFhLFSrlZy9fpDNHVreXceI+xH0=;
 b=jaH1RGQ5bEbz1Cq5pQP9Vwnq1+fo2vGaoNDCfAVNCkHFzHbWVZJIbHYtx/oZHz1n/r
 r/vTdJEWSfqI36a6uw1RWDI/rMb0x56Ma9hbPfgKpWSuxA6VsB1TYLOOgQ5h95CVU71S
 VwUwduTL4CI9HMzAE/MylDJBp4ZeUApETC97ZaUp78I4wP79YNAqEVKOoNgveM2dbynJ
 M9eC3acE0FnW+xiX8tPgNAF0vSQ67CXJ+PyyOGfXr9Cl2hl3vXNuSGpsY9A2RAw/gmaf
 e1nduvXJ84loUk9+7233nP30YHnnoePdCmBR5BcGiWlFQ8HmKvFh0fmDr5WNHhZCpIbz
 MEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940804; x=1687532804;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mJmgLNaYT6y642AgOFhLFSrlZy9fpDNHVreXceI+xH0=;
 b=II0PFsgvYZRhUysQNPoVSZPLsGW2F8fSRYKT2p7MSrIxylDHrHVXQ0cjup5m4MKMwj
 A9pNIaqWFRADWWvm+cmMEkOnLp33LvfCbW8daVx8dmshM7NXNkup9ffYhepcsSEyYvQl
 JVSMrvPmhQ895GLaI/iIIAIpBbLIPRmVIn6jLdQsPM3nzu7iCWRbykfavMTOx0Lun57p
 vA9UVlj6iVSMDp7Kpb2Dr13buLJF6PGtwvL8tvsloF4L4ok6RBwWq4TkIYzrruAuHPPD
 twNY/YJrJfEclVDWPx55df/tTvFyHzopQfLJYCg5Ebn9CKisUhHHIGv+clbYojIL5Y4G
 wjhw==
X-Gm-Message-State: AC+VfDzP2DIb9uNeywvpABcM9NaLjxSc70jaXbE4TZ9HeB2ejDLB6l40
 WWmd3C1fF7YpGKBlNIYaT6AXiA==
X-Google-Smtp-Source: ACHHUZ7YnotjILFsmvqdwAQNUJXOjgMhOSAgqRKsGFK7USV4p9L2B51LfymICNlhTqa5ExdRjsJnkA==
X-Received: by 2002:a5d:5607:0:b0:309:5029:b071 with SMTP id
 l7-20020a5d5607000000b003095029b071mr60802wrv.45.1684940804584; 
 Wed, 24 May 2023 08:06:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y10-20020adff6ca000000b002f103ca90cdsm14797333wrp.101.2023.05.24.08.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:06:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F209D1FFBB;
 Wed, 24 May 2023 16:06:43 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-4-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>, Peter
 Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, David Hildenbrand
 <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/10] hw/scsi: Rearrange meson.build
Date: Wed, 24 May 2023 16:06:33 +0100
In-reply-to: <20230524093744.88442-4-philmd@linaro.org>
Message-ID: <87h6s1vke4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> We will modify this file shortly. Re-arrange it slightly first,
> declaring source sets first.
>
> No logical change.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

