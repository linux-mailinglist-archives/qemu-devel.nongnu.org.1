Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE96707D3A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaG9-0005rz-Qi; Thu, 18 May 2023 05:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzaG6-0005rV-QX
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzaG5-00083r-9P
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684403356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vRd+lHne9UXH/fGhg39XeK4jgNBBN5NEHZR9iTW19Z4=;
 b=V5OtuHQjeLpm+woutSLi9d6ohck1vpKWLo8TIJj5TjRDvqXHh3g9FPMJdSWi8h4N7hVIhH
 VgjorWVV5J8FsoIqrbUL67TKvuUCBnYauN6gVb92p4ffZEqnhyGnoCkAtS9tqMP2xQDcTi
 JuB8FultE+uh5UIjjVkSF93jbPO2NeA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-1l61p0IJPZi6Wdi53g-qbQ-1; Thu, 18 May 2023 05:49:14 -0400
X-MC-Unique: 1l61p0IJPZi6Wdi53g-qbQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42ceb4a4fso6871085e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684403353; x=1686995353;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRd+lHne9UXH/fGhg39XeK4jgNBBN5NEHZR9iTW19Z4=;
 b=dIgHvukTD8sIudzmF2S44i0uBxNnAyGfHkYThHHFMj3swJKqhR80nCFzPbgIJunfYV
 yRfmWdtCKqEv7TPxkFGftUdmSrG6rnWLA7xshJn/TwCarDG+4lf9YigdT1pF4RO8gAys
 lEVtdQkG6rmLsf7opm1ByyZD4KxVl5RKafQO8GrHgAbIjwh4thZ4E4roZJVD1yjrujvi
 GVOz5hvAmR/1ADjgJiUuw95KuxSOZ2Zq/VbycAcogtR6L1TAwNQ1HKh9rkkOT5lsvMrK
 5nb0Kr08EvJrd+yfbX7/U3rKBPaW/bLEdDLDfdswWzufSMk6LYbceaQpcY/GnFi3hy7c
 6VLQ==
X-Gm-Message-State: AC+VfDyezvTgASL+cX4OI/bAcm2CvRRaQcRZOR3vRyJexxLaO3sGDw6k
 zizxK/LxCeekUEaHz8YfTIV/pWLhMOmQU6WRHK61KAPOXvoUn9/RB74nmi9Ty90RBeK7IqtaKPd
 LVI38rxxOL2FQsMd6PxdKw4NCBQ==
X-Received: by 2002:a5d:670c:0:b0:306:340c:4737 with SMTP id
 o12-20020a5d670c000000b00306340c4737mr906184wru.67.1684403353074; 
 Thu, 18 May 2023 02:49:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6K+nwVvu6GOTpz4GkQX7UfagvKF2vociJyGiSzbPyH8MH5di1UDK2BjZz5sOYNUcjZUXAizw==
X-Received: by 2002:a5d:670c:0:b0:306:340c:4737 with SMTP id
 o12-20020a5d670c000000b00306340c4737mr906173wru.67.1684403352778; 
 Thu, 18 May 2023 02:49:12 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o14-20020adfe80e000000b0030644bdefd8sm1612293wrm.52.2023.05.18.02.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:49:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH 5/9] util/bufferiszero: Use i386 cpuinfo.h
In-Reply-To: <20230518044058.2777467-6-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 17 May 2023 21:40:54 -0700")
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-6-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:49:11 +0200
Message-ID: <87r0redl60.fsf@secure.mitica>
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
> Use cpuinfo_init() during init_accel(), and the variable cpuinfo
> during test_buffer_is_zero_next_accel().  Adjust the logic that
> cycles through the set of accelerators for testing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Semi related to this.

For migration, I check every single page to see if it is full of zeros.
But I can promisse that it is just a page (i.e. 4KiB, 16KiB or 64KiB,
correct alignation, correct length, ...).

Will do it make sense to have an special function for that?

Yes, I have found with perf that bufferiszero() is quite high.  No, I
haven't try to experiment using a function that is optimized for the
page size in the architecture.

What do you think?

Later, Juan.


