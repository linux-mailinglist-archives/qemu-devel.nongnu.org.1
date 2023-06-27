Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB673F74B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE47M-0004nI-DI; Tue, 27 Jun 2023 04:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qE477-0004l9-Ox
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qE475-0001Oa-O0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687854709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfCLFSNeDbxBiCsNELMzC66C7znPv88EnFZkpXDZz4Q=;
 b=C36gnVgxf9mZWejegqlxFQaArNF7BLzqZdwA+LuCkeuQYIyp9z0uzykTvhU4J+liw9o/P7
 NLcQA2HzN54k0la1RPIjYGGOV0aVlpWDCqCZmftGbMKDaJXBQuu46L2Dtjr4PorzBkRqnm
 QV8d2ioKKPtpMFZds+lEvyjQM0MvFB0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-OS-X_1HbNb-RA9xGDAd3Jg-1; Tue, 27 Jun 2023 04:31:47 -0400
X-MC-Unique: OS-X_1HbNb-RA9xGDAd3Jg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so339350766b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687854706; x=1690446706;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfCLFSNeDbxBiCsNELMzC66C7znPv88EnFZkpXDZz4Q=;
 b=aeAYB6btLEIrI5nwvevJB/h8Z5+mnlSqIsTXj6jyV2dPYNcJ2GJFr6kjAlV3r0kBVy
 FLp3/bElK8+9Y71gZkFwQOL4yM5ZCaFMS4638GRR5jhb2z8M0AliqXr1h4988fmvvl6f
 XCk9u7pDNQyCIQW4qgPtVGHO9saRjy73fZFi7u+oDBMM2QxmySsYBHh2QeHqVuGacOgK
 Lnic98fLHEZRSpFOuPwTelvP4joTLXMLnVSPu67dmkcZYKLyY63i4qcDssB3wd2lpzwi
 0adRUeEz/kIsN1h/2gS9TTIj3xv5aQS0pjb3ElukPewfRdQtThKMaYVwH0p7yfa5M7Rq
 0Aug==
X-Gm-Message-State: AC+VfDwNNH16y5Qun6wVWWhDuXje/kk/+yNGM2FgEc2PAwikRuILtBHF
 s1OJGDx3WWCGo97DesgGJ4Jixpth2UqnDsaS9BDiey6/UzZs3Y1iEOyZbvxK6wRiF4cJbB3BcB4
 GGBzuIJIu79HyTLXketJ6xZo=
X-Received: by 2002:a17:906:c359:b0:98d:63c5:d135 with SMTP id
 ci25-20020a170906c35900b0098d63c5d135mr10822650ejb.54.1687854706765; 
 Tue, 27 Jun 2023 01:31:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yoIu7pZondIwuO4cYMXXmH3GGdKsBeQwk1QEbw0k3LIh2R6N7KTBh/f01c9MY73SZhj51yg==
X-Received: by 2002:a17:906:c359:b0:98d:63c5:d135 with SMTP id
 ci25-20020a170906c35900b0098d63c5d135mr10822639ejb.54.1687854706541; 
 Tue, 27 Jun 2023 01:31:46 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a1709062c0800b0098921e1b064sm4254740ejh.181.2023.06.27.01.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 01:31:46 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/2] i386: Fix Hyper-V Gen1 guests stuck on boot with
 'hv-passthrough'
In-Reply-To: <20230612084201.294248-1-vkuznets@redhat.com>
References: <20230612084201.294248-1-vkuznets@redhat.com>
Date: Tue, 27 Jun 2023 10:31:45 +0200
Message-ID: <875y79paq6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Hyper-V Gen1 guests are getting stuck on boot when 'hv-passthrough' is
> used. While 'hv-passthrough' is a debug only feature, this significantly
> limit its usefullness. While debugging the problem, I found that there are
> two loosely connected issues:
> - 'hv-passthrough' enables 'hv-syndbg' and this is undesired.
> - 'hv-syndbg's support by KVM is detected incorrectly when !CONFIG_SYNDBG.
>
> Fix both issues; exclude 'hv-syndbg' from 'hv-passthrough' and don't allow
> to turn on 'hv-syndbg' for !CONFIG_SYNDBG builds. 
>
> Vitaly Kuznetsov (2):
>   i386: Fix conditional CONFIG_SYNDBG enablement
>   i386: Exclude 'hv-syndbg' from 'hv-passthrough'
>
>  docs/system/i386/hyperv.rst | 13 +++++++++----
>  target/i386/cpu.c           |  2 ++
>  target/i386/kvm/kvm.c       | 18 ++++++++++++------
>  3 files changed, 23 insertions(+), 10 deletions(-)

Ping)

-- 
Vitaly


