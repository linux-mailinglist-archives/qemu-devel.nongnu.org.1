Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C388871F041
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ljK-0006r9-6q; Thu, 01 Jun 2023 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4ljH-0006qa-Av
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 13:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4ljF-0004eG-Hn
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 13:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685639088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=681bbtB/3AANv7d2dLjxnRFA1isMzPV0ejQon+WU+qw=;
 b=bVIR4arYLvfgidREqbAHXBgoY4XGoUoiW23sX0nif3SmtUNKQKBt2KMAwfWgnFP5GTW5Yo
 rdpozywkUAPDnsX56T5EJXxwaP4t3SaEg5x0AHoWUuSgahaEUwZtAesbK626DdO7xsamSI
 22OEaWlMBGhlzBwSshYa5c6/2KbxLag=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-OuEBa4OoMyiisw-8G4ZTnQ-1; Thu, 01 Jun 2023 13:04:37 -0400
X-MC-Unique: OuEBa4OoMyiisw-8G4ZTnQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62849c5e9f0so48076d6.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 10:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685639072; x=1688231072;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=681bbtB/3AANv7d2dLjxnRFA1isMzPV0ejQon+WU+qw=;
 b=NUNdpZVHYFcsDu9wI3KG25Wwwjp0Ad9S711gnNlpdCPgfUbW5t7+ME4d9kx2msZauh
 Cwu/c8JxWHzy3dnc1e0VImqaI4SNjDxjYkUTYFMcvPRm9GqaYY0rMsJg7wgYCUnC20ww
 m6mxQWFH6cpTlaU8eIT5lMp5oDM2T5jnZMP16xg2IKD//2AUiM47hz5r3NEwpGcvAXRj
 9whCWMj/yyF53ZxlKISC3TCHhQr2g/wsn+IgeyGxumKdwzO1WVWTQfif+Ays7eN/6FK5
 5TaRXZGs4YNCv+x9NzMPQYtQ3ZrJYl7++6h2I0TTuznCykeksKNcmPANo3SyiGN2JWFU
 rHpQ==
X-Gm-Message-State: AC+VfDwoKTdpQXX7Onn040PakE51sd6ocGFpAJM2e7Yp17mY9VOWCnag
 nOD4x/M/PTffRosI8m1ferRpzmZXrnq/1WPxwutlpudQ+gS9O1l9syH7n5VeyNT2YtKcZESdAEQ
 i08jqBOlrQk5LAnM=
X-Received: by 2002:a05:6214:411b:b0:626:2f1b:b41c with SMTP id
 kc27-20020a056214411b00b006262f1bb41cmr8139564qvb.3.1685639071924; 
 Thu, 01 Jun 2023 10:04:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6d81QiJ/y3GrqFMe1aAsN8lavioEijJkAE+uY69Meh5HLl6X7CF6h8lc8irU4xPFvqMlY8nA==
X-Received: by 2002:a05:6214:411b:b0:626:2f1b:b41c with SMTP id
 kc27-20020a056214411b00b006262f1bb41cmr8139542qvb.3.1685639071659; 
 Thu, 01 Jun 2023 10:04:31 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 f16-20020a05621400d000b006262d158ab9sm4180347qvs.124.2023.06.01.10.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 10:04:31 -0700 (PDT)
Date: Thu, 1 Jun 2023 13:04:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Message-ID: <ZHjPnfnOCQpjsbiG@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com>
 <ZHi9OQz8PGuHMPpN@x1n> <ZHjBw2E+eJKNsniO@redhat.com>
 <ZHjFzH9zT34MIBEv@x1n> <ZHjJGjZKgyaT4EO5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHjJGjZKgyaT4EO5@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 05:36:42PM +0100, Daniel P. Berrangé wrote:
> > The problem is non-live is already not real world usage in most cases.  It
> > seems we all agreed that it's the code paths to cover not real world usages
> > in the tests, or maybe not?
> 
> The cases that i made run non-live are exercising code paths that
> are only relevant during migration setup, so the non-live vs live
> status is irrelevant to the code coverage attained for those tests.
> Other remaining live tests give sufficient coverage for the live
> scenario

IMHO actually I think it's good we discuss about the goal of target of what
qtest plays a role here, hitting the issue of over-used CI and test running
too long.

For migration tests I'm not sure how Juan sees this I'd say it's good
enough to make it "just to cover code paths as much as possible".

We're never covering real use cases anyway, IMHO, if we start with 128M VM
running sequential dirty workload only.  We still need to rely on real
migration tests carried out elsewhere I believe.

So I'd say we're fine to leverage a new parameter especially if the
parameter is simple enough (for logical change I only expect a few LOCs
with switchover-hold) to help us achieve it.

Let's keep that on top anyway, no matter what.  Thanks.

-- 
Peter Xu


