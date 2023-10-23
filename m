Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5D7D3194
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quso1-0006Ij-UW; Mon, 23 Oct 2023 07:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusnz-0006IL-V9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qusny-0007sZ-6J
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698059345;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aoZLsKuBj7kVdctgAhRIl3p0RtitF8AvMojQYzER46U=;
 b=gCeaQW5hmPFIBKILd+4KfM4UkVbIZ7omSsqCfoJri9xCmKLeggYLw3Zvxm+Oy7MH0iinKs
 A0TimITOr6PuPRcEDYft64Ctq7U0MmYRfadV6HBYoXQFa8x3cZ/OgTQGYaNH1Y7BJIO5iw
 8N8i497xEdJgd+jFV84MuLLQInXowU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Gk8Ez-u8PIWxwFpMLthkHg-1; Mon, 23 Oct 2023 07:09:03 -0400
X-MC-Unique: Gk8Ez-u8PIWxwFpMLthkHg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so16265995e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698059342; x=1698664142;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoZLsKuBj7kVdctgAhRIl3p0RtitF8AvMojQYzER46U=;
 b=DWEIhWZbfZjgBZNketQV8sPXjNAItlq97QW/Dd0WyfpyDPSXReRzNVW8sdG4WjF3c7
 XOgkb72euf+aNNCe8Wn7KqGdB5hX85rZDelJ7tTPtghDBldFMgSAgDOD61vcHWhH2ZI6
 rweq02Dtv+FYnRVoUwczkPyFgJTpbVHxnAalsrjkdKVOaVupyewMdme9KvwN7I4x6w2f
 dgBf7SW5M8DNC4vQYbUoOfbITnRBqbkZJoTcPS9q5Ml16le8Os0dIx/iOSRC5eVUXIa4
 +kBzcDZRLgsw1YGGg017Gle2/nyJkYT6SGjWt76CjHA+pa3ZnE5ovMRI26Puk5grC4jr
 pFWw==
X-Gm-Message-State: AOJu0YwEpKDmi04DfMNkl1j8IK6FRjuH52fhkOmeoREMNKRdqz+vPFbe
 D+5kbf22kPSI66QJcOKUT+j/SIwk8gZ/LK9DRzCsMsx5uXXEWDESdRZGRTBYQA9XkD8PiR9Nt4Y
 hvsEie2RZ8sZEAag=
X-Received: by 2002:a05:600c:4f91:b0:408:49cd:ebf7 with SMTP id
 n17-20020a05600c4f9100b0040849cdebf7mr6726981wmq.22.1698059342747; 
 Mon, 23 Oct 2023 04:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRGPweDRDhDoK69m7nH1mcGUkdHNwWp0AZ29HXKeQA2nvRGIcTjE/kRbPo7xJ4K1KNUr18Tg==
X-Received: by 2002:a05:600c:4f91:b0:408:49cd:ebf7 with SMTP id
 n17-20020a05600c4f9100b0040849cdebf7mr6726969wmq.22.1698059342373; 
 Mon, 23 Oct 2023 04:09:02 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f18-20020a05600c155200b00402ff8d6086sm9177378wmg.18.2023.10.23.04.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:09:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 1/3] migration: Add documentation for backwards
 compatiblity
In-Reply-To: <ZGQUMyKBbkLlsDhD@x1n> (Peter Xu's message of "Tue, 16 May 2023
 19:39:31 -0400")
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-2-quintela@redhat.com> <ZGQUMyKBbkLlsDhD@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 13:09:01 +0200
Message-ID: <875y2xtx2q.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> wrote:
> On Mon, May 15, 2023 at 10:31:59AM +0200, Juan Quintela wrote:

[..]

>> +When we do migration, we have to QEMU process: the source and the
>
> s/to/two/, s/process/processes/

done.

>> +target.  There are two cases, they are the same version or they are a
>> +different version.
>
> s/a different version/different versions/

done

>> +The easy case is when they are the same version.
>> +The difficult one is when they are different versions.
>> +
>> +There are two things that are different, but they have very similar
>> +names and sometimes get confused:
>
> (space)
>
>> +- QEMU version
>> +- machine version
>
> It's normally called "machine type", so maybe use that?  Or just "machine
> version / machine type"?

machine type version

>
> This is definitely more detailed than I thought. :)
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks, Juan.


