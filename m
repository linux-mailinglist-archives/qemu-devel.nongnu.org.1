Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78069750799
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYer-0007R7-3U; Wed, 12 Jul 2023 08:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJYej-0007QY-0N
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJYeg-0001zx-Bu
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689163753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9AFLlhJhpa6EmuksTA9ykGb0fywXkY0YEZOU01qUtQ=;
 b=KsnT4VNr2IBcHD73eTeeq3vsX6KSXhvirIBFoxwkPXxuaAAu0I9Sv6uZza7YK+mBu+XSyo
 1BRHjaXPQ1Bl48F6dUHV1+x3KSR0hISsaRe+fBlIlI7VekyG+MrDRbJcwdnSl9Ft7GzDdH
 Cf0Ldv1m/Nm6d2swjSUHUgtSc0m31as=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-atEsC8ECOj-4MZlkW2TXBg-1; Wed, 12 Jul 2023 08:09:12 -0400
X-MC-Unique: atEsC8ECOj-4MZlkW2TXBg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b7254099ffso27453501fa.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 05:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689163751; x=1691755751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9AFLlhJhpa6EmuksTA9ykGb0fywXkY0YEZOU01qUtQ=;
 b=h23Jc5pwv6prFziLtOLb4PdC/Xqw/t7WNnVv9LxAIv0VX8jyPKy7wAbNk+nJR8dTD3
 AmYY86WU98SSmHwpp5FOf0s8in2fqN64d2ogR0HOAGN66lteEE8Hpoc+JKPobGGX6pM7
 VcKxu8GCS5bkuisZBI+ttokq65yEyqAjtdPqbkR4RCgGdVXMJQlJb8jojHltPc/k1Kwk
 TAwY81Jdj0tn3noLpm5fzuSCPJsUGd03Fx0k38/dZmzfdooGkAB0F7rEulfRZlSFtd5J
 udSRUlEOfThIFjKGNbihP3T74+4z5/kZg1pdc0og08FoEJYxke/0SOGfNITTZf0JegqF
 +l3Q==
X-Gm-Message-State: ABy/qLbvWeBruRTGivcaHYLOiRm7LeBYZKND8AEeCZY5lFrDNeFRaFIt
 U+whTB2qiDB/006b7oKSt7dryqJRUg1HucoNvmYtsRxt/0hkFyXu/TmrIoob/J+GrrqN9MUnvYL
 3iAZYfUaiILAz+Qk=
X-Received: by 2002:a2e:a30b:0:b0:2af:25cf:92ae with SMTP id
 l11-20020a2ea30b000000b002af25cf92aemr17824661lje.22.1689163750877; 
 Wed, 12 Jul 2023 05:09:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHo0pENqCSziWIbHk+RjBgJLZdrE6UqHKcPbpuuqI6oPByvtHIZndIqQFY9SI+MeTLEH9vntA==
X-Received: by 2002:a2e:a30b:0:b0:2af:25cf:92ae with SMTP id
 l11-20020a2ea30b000000b002af25cf92aemr17824630lje.22.1689163750415; 
 Wed, 12 Jul 2023 05:09:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a17090680cf00b0099251a40184sm2500106ejx.99.2023.07.12.05.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 05:09:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/ide/piix: properly initialize the BMIBA register
Date: Wed, 12 Jul 2023 14:08:39 +0200
Message-ID: <20230712120838.129600-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712074721.14728-1-olaf@aepfle.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA-BUS
> MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
> 32bit wide. To properly reset it to default values, all 32bit need to be
> cleared. Bit #0 "Resource Type Indicator (RTE)" needs to be enabled.

Queued, thanks.

Cc: qemu-stable@nongnu.org

Paolo


