Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 237AF71F647
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4r7t-0005RE-8V; Thu, 01 Jun 2023 18:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r7q-0005Qq-Nw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r7p-0005oy-1b
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685659832;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOUatqZ90/j1ux2D4xeC5ICT9akjXAhvlX/uynrd+LQ=;
 b=EHFfc+US+aFUEfS8pC/Nq+7p6IrVpTkh7IAM4NagkWCd2NeqQszk7LD3x6NN5CiKghWTKM
 7uGv2vxxFpssj6u8P3qo+OTnhPu3dzXze53vbfKmxeNOiR8DWgXRxPAodb2apIo6UOmaXP
 4Shz9GgERRJHtwuq4TrM6COxm/EOCqg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-LjkAKbI8Nc-0qtEsA4K9Dw-1; Thu, 01 Jun 2023 18:50:31 -0400
X-MC-Unique: LjkAKbI8Nc-0qtEsA4K9Dw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30ad885addcso1268447f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685659829; x=1688251829;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOUatqZ90/j1ux2D4xeC5ICT9akjXAhvlX/uynrd+LQ=;
 b=OEUU3NQzN1+FFQ7niFMLB8Dhf2wiTwjn9SPZFE2nxMz14sZkmddRLRuCfROKkb+aKI
 +y5kzYMwg9CXmRaMyF8lFAlkaueNso1xvkmHQlL1lJPAkdrLJhUVh2z5FgceY8pYiL8n
 e7spMUfOUqVrptPCYM1rHtabwaKCzFXKh1Ok/CRLi9jHRbGrFTVPEWlGJTh111cLzL9v
 TiYFfDinFs6JEcq0CYMr++j6riO5p6yizR9BXPbmknNUUlzXqwKzaQNLUcUMing69J44
 k4TIhs0UczOsfkb4e737sVZ8LoOF0Q35nVLm8r+x2Nf8Hoe1ZJuKST7Azzf/QKPi1WMX
 3eAQ==
X-Gm-Message-State: AC+VfDyhA9pHXcBAwE1d63vZv45vdypobOYgW4rNSA+4dBCjPFXPvQzU
 cItPefMM81RmvKvhi+GKpaOHvRsTphSsNP2IuxjKYKpVGHoXTVxcThWkyxh1qb1frFu5MHdSu9S
 dI6fqUu7udbDFXxM=
X-Received: by 2002:a5d:470d:0:b0:309:4642:8795 with SMTP id
 y13-20020a5d470d000000b0030946428795mr2908215wrq.12.1685659829030; 
 Thu, 01 Jun 2023 15:50:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RgFUA5zb+UAY7/0mSx0+hV0j4V6E2X4cz6ejnMG6JSqLh+vGx8tq/eGNSdG/flfSH6v+ikw==
X-Received: by 2002:a5d:470d:0:b0:309:4642:8795 with SMTP id
 y13-20020a5d470d000000b0030946428795mr2908202wrq.12.1685659828762; 
 Thu, 01 Jun 2023 15:50:28 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 x15-20020adfdd8f000000b0030ae3a6be4asm11534126wrl.72.2023.06.01.15.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:50:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 09/10] tests/qtest: make more migration pre-copy
 scenarios run non-live
In-Reply-To: <20230601161347.1803440-10-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Jun 2023 17:13:46
 +0100")
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-10-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:50:27 +0200
Message-ID: <87jzwmre4s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> There are 27 pre-copy live migration scenarios being tested. In all of
> these we force non-convergence and run for one iteration, then let it
> converge and wait for completion during the second (or following)
> iterations. At 3 mbps bandwidth limit the first iteration takes a very
> long time (~30 seconds).
>
> While it is important to test the migration passes and convergence
> logic, it is overkill to do this for all 27 pre-copy scenarios. The
> TLS migration scenarios in particular are merely exercising different
> code paths during connection establishment.
>
> To optimize time taken, switch most of the test scenarios to run
> non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> a massive speed up for most of the test scenarios.
>
> For test coverage the following scenarios are unchanged
>
>  * Precopy with UNIX sockets
>  * Precopy with UNIX sockets and dirty ring tracking
>  * Precopy with XBZRLE
>  * Precopy with UNIX compress
>  * Precopy with UNIX compress (nowait)
>  * Precopy with multifd
>
> On a test machine this reduces execution time from 13 minutes to
> 8 minutes.
>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


