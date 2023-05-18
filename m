Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB783707CB0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZoI-0004cv-Cp; Thu, 18 May 2023 05:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZoG-0004cM-Kh
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZoF-0003aY-AD
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684401630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PVecZB/Ci6IpfVpBwP5kQiomynRgktVqqrz/gQaYccI=;
 b=QtEbNGvpfq44N7eD1Sv052hsVB1rrZkBuNnDiRzvYGiTP1z9aHwiks3bAT7BbShe6+eh2l
 LaLULbuzfebPzJvvpj1t/VVVNAM9ZCKe2cx69d/7/qTzoS9vW5YdLz6R37ckl8GZ2j4sfp
 oSCpnuvIfH8wEiH5/dWbL8nZdYsv+68=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-AouzS-lpNl-HGHNj_jlTCQ-1; Thu, 18 May 2023 05:20:29 -0400
X-MC-Unique: AouzS-lpNl-HGHNj_jlTCQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30640be4fd0so702840f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684401628; x=1686993628;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVecZB/Ci6IpfVpBwP5kQiomynRgktVqqrz/gQaYccI=;
 b=EfnWnwAgQc6IJ3Cmdo1oKt5JlWMfVUFVVwSmN8GHoFYfAUcqtd5x2LMrNSTdTMknQJ
 W/Jj30PHNRxIxqAiyljzRWEWFc4EeDWuC6UbVdDS9XEkcP/b0BxbVnID8huECU50sBMs
 lwG6ZcpHNZ56CN39dM+FEzwSB8MnJvvgrCKU7kEn5ya3QtB0Af4HMNWoJRCRQ21jhQtj
 H1+a9pKw9fIYgPMIbZ4n/QSIMpGy1JwkpmEMJmBzf+br6BVf/XSSWJPaezMSmxGTBUSS
 JUylOJMethwUBPNyer7G+W5nuDmmjISrVQWUgIF+pD49rT3yRoNlzXWo5nCzgqq6lvXd
 YuDA==
X-Gm-Message-State: AC+VfDxJbc0zfJ2p9wQVqpNRIg2/nhcnd5sRi76VZ2prUTgLHGPG3N4A
 1M6wJQ2WMowet+b9J9yQWh2vRevbo41+iTUBxFDimLoW9r86/zrWz7adP52J1P1KKFuN6kyhpBN
 2cw1l8V26ZA+6V5g=
X-Received: by 2002:adf:f409:0:b0:309:5dc:4c30 with SMTP id
 g9-20020adff409000000b0030905dc4c30mr823078wro.62.1684401628099; 
 Thu, 18 May 2023 02:20:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4AXzyTRS8QA9IlMUexdOV7WyVL34sUJgGM+iyR1YAvirM0eBylnUwHToN+x7TCkOx8tMOZ7Q==
X-Received: by 2002:adf:f409:0:b0:309:5dc:4c30 with SMTP id
 g9-20020adff409000000b0030905dc4c30mr823068wro.62.1684401627878; 
 Thu, 18 May 2023 02:20:27 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q18-20020a5d61d2000000b003079c402762sm1549398wrv.19.2023.05.18.02.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:20:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 8/9] migration: Build migration_files once
In-Reply-To: <20230518044058.2777467-9-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 17 May 2023 21:40:57 -0700")
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-9-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:20:26 +0200
Message-ID: <878rdmf12d.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> The items in migration_files are built for libmigration and included
> info softmmu_ss from there; no need to also include them directly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Ouch.

Good catch.

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


