Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8EF7C5E6E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfs5-0003gX-MK; Wed, 11 Oct 2023 16:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfrv-0003gG-N4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfru-00026V-9w
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056305;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ONeQCjKK2qdm7Mx90Ufh2RPy1Y90A/P28jTLdhYbims=;
 b=LyaItswHEhh7fUO+fnjsNl6hrJxhWTrFEFBigCvlezp2bJ8h/c9TYQQWR/y8DQ4hVWySsB
 4Mmdk5IcbIdPgshKCCyDif5sYGgS3jqHQdKGYi2Oj9o299/nuW1wkKjhr1+vQ1MgNjexfT
 R9DIeIZZ3eBFeSgLNQ8rz6//UZDy8Yc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-iNd2LaFBOayg_Ps9ExZb-Q-1; Wed, 11 Oct 2023 16:31:34 -0400
X-MC-Unique: iNd2LaFBOayg_Ps9ExZb-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-323306960e3so118061f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697056293; x=1697661093;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONeQCjKK2qdm7Mx90Ufh2RPy1Y90A/P28jTLdhYbims=;
 b=W7DHpkHLDbQshj+WMIkfZ3tONSLiCFw24ntfHR0m+vIESbqcYhxT8nL06LkwhqYMrT
 NoQcDzA9SD0INO/89he2LYNaC8PKzg9AHWheW8olbCssvZQjsaEpCK+nCkus++NkhIJq
 rPkFExHiEUGsMQQbaQsdiGShBECpJiz9Mi7vIZ6PRPNEAPAQOE3yEN7GCm9Nu5seAy8S
 ktH9Lmh+0RKtg1lWP1lKF3dz9RUznR92mXyEjPCANDE7X21a7vUc0B7xthBGzMdvT3TM
 +5EdE27/A+NLYwzBDVrIAW3103dj6zKsenrV6wXDOpG+iwgS8BBGJ/7VmKe7fH6Zv5I6
 QbnQ==
X-Gm-Message-State: AOJu0YwsDePeYdaOHf78lNK/1GLC7KnFbT9OBC/TClUjv/grLkk1Zb4M
 tsZdvnePDOUEwVy0EeDCPGY/KpgfQwaR6LdFEIbJ2mTerK/DJ/jY1on2YvPvyGHs0vbjSevx6u4
 HNWOnR5pA6C3A+Js=
X-Received: by 2002:adf:ce84:0:b0:32d:8a32:3b2f with SMTP id
 r4-20020adfce84000000b0032d8a323b2fmr1311760wrn.16.1697056292983; 
 Wed, 11 Oct 2023 13:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1bhzbsL26y6IYnxb08W5d54RZdYzfzpfSYpqXRAVMZpk5P8I4OZRaSYTNcPgl+pcPOfIUOw==
X-Received: by 2002:adf:ce84:0:b0:32d:8a32:3b2f with SMTP id
 r4-20020adfce84000000b0032d8a323b2fmr1311753wrn.16.1697056292684; 
 Wed, 11 Oct 2023 13:31:32 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d58c3000000b0032d8f075810sm837wrf.10.2023.10.11.13.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 13:31:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "peterx@redhat.com" <peterx@redhat.com>,  "isaku.yamahata@gmail.com"
 <isaku.yamahata@gmail.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] migration: refactor migration_completion
In-Reply-To: <DS0PR11MB637312D6D5D3E178D4B034D5DCCCA@DS0PR11MB6373.namprd11.prod.outlook.com>
 (Wei W. Wang's message of "Wed, 11 Oct 2023 14:45:28 +0000")
References: <20230804093053.5037-1-wei.w.wang@intel.com>
 <87v8bdbac2.fsf@secure.mitica>
 <DS0PR11MB637312D6D5D3E178D4B034D5DCCCA@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 22:31:31 +0200
Message-ID: <87mswo7vfg.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> On Wednesday, October 11, 2023 8:41 PM, Juan Quintela wrote:
>> Wei Wang <wei.w.wang@intel.com> wrote:
>> > Current migration_completion function is a bit long. Refactor the long
>> > implementation into different subfunctions:
>> > - migration_completion_precopy: completion code related to precopy
>> > - migration_completion_postcopy: completion code related to postcopy
>> > - close_return_path_on_source: rp thread related cleanup on migration
>> > completion. It is named to match with open_return_path_on_source.
>> >
>> > This improves readability and is easier for future updates (e.g. add
>> > new subfunctions when completion code related to new features are
>> > needed). No functional changes intended.
>> >
>> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> 
>> There was some conflict with:
>> 
>> commit d50f5dc075cbb891bfe4a9378600a4871264468a
>> Author: Fabiano Rosas <farosas@suse.de>
>> Date:   Mon Sep 18 14:28:20 2023 -0300
>> 
>>     migration: Consolidate return path closing code
>> 
>> (basically the traces and the rp_thread_created check were already on the
>> tree).
>> 
>> BTW, the diff is uglier than it needs to be.
>> 
>> You can add to your global .gitconfig:
>> 
>> [diff]
>>         algorithm = patience
>>         renames = true
>
> Yeah, this generates a nicer diff, thanks.
> I'll rebase and resend it.

Already on the pull request.

I have to fix the conflict, but it has the same changes that yours as
far as I can see.

Later, Juan.


