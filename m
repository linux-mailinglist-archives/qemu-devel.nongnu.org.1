Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63CD7CD964
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3wn-0003pf-C3; Wed, 18 Oct 2023 06:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3wk-0003pM-IH
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3wi-0004tK-Pg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697625516;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XtfnwuUw37fWhsck1/q0Mts5StDFOI0eV8w+2kUKTzY=;
 b=V2J8rM8+MV0VFF8HMTdxMKo/ICoMeDftrwdg7PmxPzwmudUujR3Z2+4AVsvOB4QEID/TUL
 lq4bhAWulbxRPw/VGZwzM+pzOktAwXte9M3sB+RK8KQzs0SsckELpeDGkZW93Pk0bWiMFE
 mJWsqWFO6Dg29EQJ7+MOsgXTgpBSc74=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-8cn93yfmMIGsFdg-guxVMQ-1; Wed, 18 Oct 2023 06:38:19 -0400
X-MC-Unique: 8cn93yfmMIGsFdg-guxVMQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c503804667so52295811fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 03:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697625494; x=1698230294;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtfnwuUw37fWhsck1/q0Mts5StDFOI0eV8w+2kUKTzY=;
 b=LFuYpZdIfuKCiH0WmiLzILMthrwA9ITzLySx7bKZpEVF3NQCsEttzGLCwvxjlMu9MK
 FmiNXQLnQ+OerEvPUjOoWB4BdqqCqQ5WejqmMBcHRMpCexCJH5xhp0hN86IFxPcbUCO5
 9XkHrIcY6SP7wcTamc0FGBbEWGxk2FtYLpchx+GOreF3A1RbptrmF3JNGOTgLZqM6f7R
 cIUUcVBz+PCjOPiqfIPwIuusZhTeo06lf0vDEZfek47ca7QIFNED1Cz6hXJ2MlZudnQX
 xeNjbs0mvoUSqGMAXedwjKM7bGw2c+/Ofwno5n3qZ5nVz8SNUVAC+J5Ff9/6a9gpCUGS
 y6bw==
X-Gm-Message-State: AOJu0Yw3yDkzBgjmdbks3oiA3meQlF6aq9u3pbeu8hquwj9oqB7EvHRV
 StIVa9yvVA4DUxCNefVU7+IFij8/WC9n4okMDcOfHl2UrmKX4fjDppNDkoSoKCjaVJ0kaxCcyrd
 3xV5GECo2NdXmF4TGzBqVSkcN3nSBzZSDzZocOIOq4un7i7G2f5Ss1EH7MYSUFxa+tQqf1hUeW8
 hZcz+e
X-Received: by 2002:ac2:4899:0:b0:500:7c51:4684 with SMTP id
 x25-20020ac24899000000b005007c514684mr3530535lfc.56.1697625493783; 
 Wed, 18 Oct 2023 03:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDk+ZJni8CSaSR5lvRGMZ5XpZw/RT5PC0aOgePW30L5KVNrDr4sQNZb2Nk5cNKP/6g7KryHQ==
X-Received: by 2002:ac2:4899:0:b0:500:7c51:4684 with SMTP id
 x25-20020ac24899000000b005007c514684mr3530508lfc.56.1697625493313; 
 Wed, 18 Oct 2023 03:38:13 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s13-20020adff80d000000b0032daf848f68sm1825072wrp.59.2023.10.18.03.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:38:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,  Fam Zheng <fam@euphon.net>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>,  libvir-list@redhat.com,  Hanna Reitz
 <hreitz@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v7 0/4] Migration deprecated parts
In-Reply-To: <20231018103204.33444-1-quintela@redhat.com> (Juan Quintela's
 message of "Wed, 18 Oct 2023 12:32:00 +0200")
References: <20231018103204.33444-1-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 12:38:10 +0200
Message-ID: <87bkcwxlkd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Juan Quintela <quintela@redhat.com> wrote:
> Based on: Message-ID: <20231018100651.32674-1-quintela@redhat.com>
>           [PULL 00/11] Migration 20231018 patches
>
> And here we are, at v7:
> - drop black line at the end of deprecated.rst
> - change qemu-iotest output due to warnings for deprecation.
>
> The only real change is the output of the qemu-iotest.  That is the
> reason why I maintained the reviewed-by.  But will be happy if anyone
> of the block people ack the changes.

I forgot to include the link to the CI of the previous failure.

https://gitlab.com/juan.quintela/qemu/-/jobs/5314070229

tput mismatch (see /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file-183/183.out.bad)
--- /builds/juan.quintela/qemu/tests/qemu-iotests/183.out
+++ /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file-183/183.out.bad
@@ -28,6 +28,8 @@
 { 'execute': 'migrate',
        'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
+warning: parameter 'blk is deprecated; use blockdev-mirror with NBD instead
+warning: block migration is deprecated; use blockdev-mirror with NBD instead
 {"return": {}}
 { 'execute': 'query-status' }
 {"return": {"status": "postmigrate", "singlestep": false, "running":
 false}}



>
> Thanks, Juan.
>
> On this v6:
> - Fixed Markus comments
> - 1st patch is reviewed
> - dropped the RFC ones.
>
> Later, Juan.
>
> On this v5:
> - Rebased on top of last migration pull requesnt:
>
> - address markus comments.  Basically we recommend always
>   blockdev-mirror + NBD.  In deprecated.rst we also put the posiblity
>   of using block-incremental and block, but we state that they are
>   also deprecated.
>   I know, I know, I deprecated them in the following patch.
>
> - Dropped the removal of block-migration and block-incremental I am
>   only interested in showing why I want to remove the -b/-i options.
>
> Please review.
>
> Later, Juan.
>
> On this v4:
> - addressed all markus comments.
> - rebased on latest.
> - improve formatting of migration.json
> - print block migration status when needed.
> - patches 7-10 are not mean to merge, they just show why we want to
>   deprecate block migration and remove its support.
> - Patch 7 just drop support for -i/-b and qmp equivalents.
> - Patch 8 shows all the helpers and convolutions we need to have to
>   support that -i and -d.
> - patch 9 drops block-incremental migration support.
> - patch 9 drops block migration support.
>
> Please review.
>
> Thanks, Juan.
>
> On this v3:
>
> - Rebase on top of upstream.
> - Changed v8.1 to 8.2 (I left the reviewed by anyways)
> - missing the block deprecation code, please.
>
> Please, review.
>
> Later, Juan.
>
> On this v2:
>
> - dropped -incoming <uri> deprecation
>   Paolo came with a better solution using keyvalues.
>
> - skipped field is already ready for next pull request, so dropped.
>
> - dropped the RFC bits, nermal PATCH.
>
> - Assessed all the review comments.
>
> - Added indentation of migration.json.
>
> - Used the documentation pointer to substitute block migration.
>
> Please review.
>
> [v1]
> Hi this series describe the migration parts that have to be deprecated.
>
> - It is an rfc because I doubt that I did the deprecation process right. Hello Markus O:-)
>
> - skipped field: It is older than me, I have never know what it stands
>   for.  As far as I know it has always been zero.
>
> - inc/blk migrate command options.  They are only used by block
>   migration (that I deprecate on the following patch).  And they are really bad.
>   grep must_remove_block_options.
>
> - block migration.  block jobs, whatever they are called this week are
>   way more flexible.  Current code works, but we broke it here and
>   there, and really nobody has stand up to maintain it.  It is quite
>   contained and can be left there.  Is anyone really using it?
>
> - old compression method.  It don't work.  See last try from Lukas to
>   make a test that works reliabely.  I failed with the same task years
>   ago.  It is really slow, and if compression is good for you, multifd
>   + zlib is going to perform/compress way more.
>
>   I don't know what to do with this code, really.
>
>   * Remove it for this release?  It don't work, and haven't work
>     reliabely in quite a few time.
>
>   * Deprecate it and remove in another couple of releases, i.e. normal
>     deprecation.
>
>   * Ideas?
>
> - -incoming <uri>
>
>   if you need to set parameters (multifd cames to mind, and preempt has
>   the same problem), you really needs to use defer.  So what should we do here?
>
>   This part is not urget, because management apps have a working
>   option that are already using "defer", and the code simplifacation
>   if we remove it is not so big.  So we can leave it until 9.0 or
>   whatever we think fit.
>
> What do you think?
>
> Later, Juan.
>
> Juan Quintela (4):
>   migration: migrate 'inc' command option is deprecated.
>   migration: migrate 'blk' command option is deprecated.
>   migration: Deprecate block migration
>   migration: Deprecate old compression method
>
>  docs/about/deprecated.rst      | 35 +++++++++++++
>  qapi/migration.json            | 93 ++++++++++++++++++++++++++--------
>  migration/block.c              |  3 ++
>  migration/migration-hmp-cmds.c | 10 ++++
>  migration/migration.c          | 10 ++++
>  migration/options.c            | 22 +++++++-
>  tests/qemu-iotests/183.out     |  2 +
>  7 files changed, 152 insertions(+), 23 deletions(-)


