Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A271F651
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:01:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4rHQ-0002wi-Ia; Thu, 01 Jun 2023 19:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4rHH-0002ta-FL
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4rHD-0007hi-Pw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685660415;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUJKWolAOrxuyualb5zQtgfi+eetc16ibLo7bDY6a/Y=;
 b=TOm0xGWUdFynUlvWtdq7jzXFDTcabYFWu2uBDG8fKxohP6R+aQGeBgeioIG86hty6STAsN
 QT0gBgcVUJyEir2PF5yguS43/A2BHkwTdLZKCeRiqqxTvMzKfPYL+M2rGvQvIyn2tEShsv
 +zvF2GHtoqPjoKrS3rXeVFttAiTZ0zI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-eyUosCRNNkiwWRWsGgQPSw-1; Thu, 01 Jun 2023 19:00:14 -0400
X-MC-Unique: eyUosCRNNkiwWRWsGgQPSw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso1077495e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 16:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685660412; x=1688252412;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gUJKWolAOrxuyualb5zQtgfi+eetc16ibLo7bDY6a/Y=;
 b=WwMObowHQEZmovXp7nggFPBooG4jR8IFsODS+LcxkdFVhjbxW1vL20F0NbL9BMWLsR
 JWYWJTo4uDlZS3GHKEpKyXrkL12Q4b+Cuq3vf6S7iGNdbBgULVwL3xvObbmOAgO0sSaB
 44Nn7cC+H9kFtVBTnWnNsYijv5vSyMZR2A5UpWtqBrdS8C+mBjZbmOG252v0ABLAPeIP
 AQq1RNXjYvGPEyZlQhoq2N9BXOhBGAaT3kEUjzsrT8H/H43fYHcFc7MsIRzhL6lq7y7m
 WtC0lTGPytwbjdoYziaArnWKo/ifCduHX8hlm+Ya3i4wvDlHvFTf8gJnyZnqqoYf/6jg
 Jf4A==
X-Gm-Message-State: AC+VfDxirAWQqJuUE2RsIEd8PxSnX6jzZPpK4/YqpW5xyAYeCs5zSGSf
 GsTI9TW4pu+m6pRIPHvXYyU/1/dPeQgTcK0tGpjWXFE4nVw5GLEBhsV+gShWmJGZG8exPet2H5g
 mihGlYhFphjn7dxUd0vT/4Scp0Q==
X-Received: by 2002:a19:ac43:0:b0:4f3:8c0d:41c4 with SMTP id
 r3-20020a19ac43000000b004f38c0d41c4mr854489lfc.30.1685660412336; 
 Thu, 01 Jun 2023 16:00:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ooVzkmuTEyG/kX4ckoOACuHFVYgv0lrF60DgUxPWGdM3cfDYqEmlvXavs5Gu40g6uZRfS+w==
X-Received: by 2002:a19:ac43:0:b0:4f3:8c0d:41c4 with SMTP id
 r3-20020a19ac43000000b004f38c0d41c4mr854480lfc.30.1685660411982; 
 Thu, 01 Jun 2023 16:00:11 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q21-20020a1ce915000000b003f602e2b653sm3586669wmc.28.2023.06.01.16.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 16:00:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,  Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
In-Reply-To: <ZHi9OQz8PGuHMPpN@x1n> (Peter Xu's message of "Thu, 1 Jun 2023
 11:46:01 -0400")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com> <ZHi9OQz8PGuHMPpN@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 01:00:10 +0200
Message-ID: <87353ardol.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Peter Xu <peterx@redhat.com> wrote:
> On Wed, May 31, 2023 at 02:24:00PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> The migration test cases that actually exercise live migration want to
>> ensure there is a minimum of two iterations of pre-copy, in order to
>> exercise the dirty tracking code.
>>=20
>> Historically we've queried the migration status, looking for the
>> 'dirty-sync-count' value to increment to track iterations. This was
>> not entirely reliable because often all the data would get transferred
>> quickly enough that the migration would finish before we wanted it
>> to. So we massively dropped the bandwidth and max downtime to
>> guarantee non-convergance. This had the unfortunate side effect
>> that every migration took at least 30 seconds to run (100 MB of
>> dirty pages / 3 MB/sec).
>>=20
>> This optimization takes a different approach to ensuring that a
>> mimimum of two iterations. Rather than waiting for dirty-sync-count
>> to increment, directly look for an indication that the source VM
>> has dirtied RAM that has already been transferred.
>>=20
>> On the source VM a magic marker is written just after the 3 MB
>> offset. The destination VM is now montiored to detect when the
>> magic marker is transferred. This gives a guarantee that the
>> first 3 MB of memory have been transferred. Now the source VM
>> memory is monitored at exactly the 3MB offset until we observe
>> a flip in its value. This gives us a guaranteed that the guest
>> workload has dirtied a byte that has already been transferred.
>>=20
>> Since we're looking at a place that is only 3 MB from the start
>> of memory, with the 3 MB/sec bandwidth, this test should complete
>> in 1 second, instead of 30 seconds.
>>=20
>> Once we've proved there is some dirty memory, migration can be
>> set back to full speed for the remainder of the 1st iteration,
>> and the entire of the second iteration at which point migration
>> should be complete.
>>=20
>> On a test machine this further reduces the migration test time
>> from 8 minutes to 1 minute 40.
>
> The outcome is definitely nice, but it does looks slightly hacky to me and
> make the test slightly more complicated.
>
> If it's all about making sure we finish the 1st iteration, can we simply
> add a src qemu parameter "switchover-hold"?  If it's set, src never
> switchover to dst but keeps the iterations.
>
> Then migrate_ensure_non_converge() will be as simple as setting
> switchover-hold to true.
>
> I am even thinking whether there can even be real-life use case for that,
> e.g., where a user might want to have a pre-heat of a migration of some V=
M,
> and trigger it immediately when the admin really wants (the pre-heats mov=
ed
> most of the pages and keep doing so).
>
> It'll be also similar to what Avihai proposed here on switchover-ack, just
> an ack mechanism on the src side:
>
> https://lore.kernel.org/r/20230530144821.1557-3-avihaih@nvidia.com

That was basically my idea and that is why I am holding the last two
patches and see if I can came with something in the next couple of days.

Later, Juan.


