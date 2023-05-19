Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A98709673
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 13:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzyC3-0000dh-QA; Fri, 19 May 2023 07:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzyBt-0000cu-60
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzyBr-0004aK-Ed
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684495346;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VExPZgq+I5WLnttLx43iPqrXkQayvRSrsiZA7628Ygk=;
 b=SAMlb4nACYsreHnpYpJ3Z+6kwXKn5ZzxMVa5B8oHM8v06ZDqefNuHEvCIw6JqdFPBuJkPb
 jE5anvRxmOViHu5ZH2f79HgNYO9bdyq3iSnezC96Xe5lNNaQNwlxKQNAFACYAGCW3mLm7L
 4LednMf84YPx/UBVxXD74JjPck0kRqM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-uZWIAA_-OJaYOpN8R7TK7g-1; Fri, 19 May 2023 07:22:24 -0400
X-MC-Unique: uZWIAA_-OJaYOpN8R7TK7g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3094b683f3dso727234f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 04:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684495343; x=1687087343;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VExPZgq+I5WLnttLx43iPqrXkQayvRSrsiZA7628Ygk=;
 b=ipU8u7a6q2p0y7QBkpjfQtyFlmqY3zg+ylOOEZfo89l0bX7oHWPJetU2B71oIj1HPL
 rOZ+KplpGq8+px5p4Bv3iJe8x+L6j1BQMdpiTTM1ZleTfHT+dnjHnReYoM8VN5xCE/zC
 NbeWD4A/SdrwGDaxASmRJouJXcOR5Si6oVVBI1Yt424SP/hphBJbAj+x+HWnhvQYU6lG
 xv3Cni92FI81zrmGkYP314Abi2+8Bz2/YeQkBGbC6iAZ9B+onStd81EfkFhPEZk5E2vZ
 twxs34A1KVqlhP20/1KaNJmUOxMij8MadtPlvbAZn84UD7RVcOe6kxX2wnCtpyFIPuPk
 zp/Q==
X-Gm-Message-State: AC+VfDzsIPglGeAUoXo0AsKqDCqnfTYZdcxiQAC8sehTADKhPhgi2P7N
 hRdEaG+pErcragjuNldiZ2Mm29o+ZmmlxLVQ7sXZD+PnwqLKiAk/J2W0ceUv9nuDQzxOgcGx/KA
 kNR2J87rZbhW3mVw=
X-Received: by 2002:a5d:540a:0:b0:309:3b8d:16a8 with SMTP id
 g10-20020a5d540a000000b003093b8d16a8mr1386062wrv.50.1684495343565; 
 Fri, 19 May 2023 04:22:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XRRN6ljRNFmyOt1TO4G0f+7s2fS50gCWeLpQN76fEbsjpoo9Vn8cHkqUQuHaEHnfjJ6vetA==
X-Received: by 2002:a5d:540a:0:b0:309:3b8d:16a8 with SMTP id
 g10-20020a5d540a000000b003093b8d16a8mr1386050wrv.50.1684495343215; 
 Fri, 19 May 2023 04:22:23 -0700 (PDT)
Received: from redhat.com (84.125.95.163.dyn.user.ono.com. [84.125.95.163])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a5d568e000000b003047d5b8817sm5002712wrv.80.2023.05.19.04.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 04:22:22 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>,  "Daniel Berrange"
 <berrange@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
In-Reply-To: <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 (Wei W. Wang's message of "Fri, 19 May 2023 02:44:16 +0000")
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <87h6saf18t.fsf@secure.mitica>
 <9def6eb4-e317-2b6d-87ab-d0aa34ea3afe@intel.com>
 <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 19 May 2023 13:22:20 +0200
Message-ID: <87jzx4y39v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

"Wang, Wei W" <wei.w.wang@intel.com> wrote:
> On Friday, May 19, 2023 9:31 AM, Wang, Lei4 wrote:
>> On 5/18/2023 17:16, Juan Quintela wrote:
>> > Lei Wang <lei4.wang@intel.com> wrote:
>> >> When destination VM is launched, the "backlog" parameter for listen()
>> >> is set to 1 as default in socket_start_incoming_migration_internal(),
>> >> which will lead to socket connection error (the queue of pending
>> >> connections is full) when "multifd" and "multifd-channels" are set
>> >> later on and a high number of channels are used. Set it to a
>> >> hard-coded higher default value 512 to fix this issue.
>> >>
>> >> Reported-by: Wei Wang <wei.w.wang@intel.com>
>> >> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>> >
>> > [cc'd daiel who is the maintainer of qio]
>> >
>> > My understanding of that value is that 230 or something like that
>> > would be more than enough.  The maxiimum number of multifd channels is
>> 256.
>> 
>> You are right, the "multifd-channels" expects uint8_t, so 256 is enough.
>> 
>
> We can change it to uint16_t or uint32_t, but need to see if listening on a larger
> value is OK to everyone.

If we need something more than 256 channels for migration, we ar edoing
something really weird.  We can saturate a 100Gigabit network relatively
easily with 10 channels.  256 Channels would mean that we have at least
2TBit/s networking.  I am not expecting that really soon.  And as soon
as that happens I would expect CPU's to handle easily more that
10Gigabits/second.

> Man page of listen mentions that the  maximum length of the queue for
> incomplete sockets can be set using /proc/sys/net/ipv4/tcp_max_syn_backlog,
> and it is 4096 by default on my machine.

I think that current code is ok.  We just need to enforce that we use
defer.

Later, Juan.


