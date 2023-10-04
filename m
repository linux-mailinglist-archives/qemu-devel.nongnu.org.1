Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3892A7B85F0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5BH-0006aO-Kz; Wed, 04 Oct 2023 12:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5BF-0006Uq-Gq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5BD-0002yZ-Vl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YDDzGXVWj15DuiYBvudmAHOUXjSH3r3uyh6TXop2udU=;
 b=Ly1m9FnG8S2PZ8ViyrLCF1cbPesL1KNb0Av4aDBjqCep3f534px74sml+UBvhFJL/byvbw
 qdrAl++eCCqKfypjHRpy4lzbnmdOm7kNnrDQlnaxC4j8pl0VfEer1zdDbhg5+15bi9lyPT
 6ZfRMgNl02k9H8S06hX05M9nMEliFic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-tXwsuTeLMlmqoAyHloIf2g-1; Wed, 04 Oct 2023 12:56:57 -0400
X-MC-Unique: tXwsuTeLMlmqoAyHloIf2g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso69105e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438616; x=1697043416;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDDzGXVWj15DuiYBvudmAHOUXjSH3r3uyh6TXop2udU=;
 b=Zsg+jEJixfWB63rCQ70R+ZRYDCVqvTm6/mojSl7BRRxZxdXeE+gRYMvrC7WZuqOKWF
 xLvH5/pIFTt8KAbfKu+qqzbJOSofjbJKPk6uNd1d058fd4Du5XOwmqa2drVnS3KBkvhX
 1rOM2kApQe7r8t3PXVo9kNBbuqMEMHIvhYTtJnRe/0RvX4HgIgU/E2A3JxDkNsWDMfZu
 wa8uWYh3izKD9iN1Y1wg7HZYo9bWtII5uJ0ug0RA3jr720EZVKVbCAK0Ab0Tvv4+4qu0
 ady9wq2tnZsaPCBFHHfmazvB89eOJ/W3ViZTE5cT42YGKr/2PW5YGTXbVjxzbXjgMHJU
 iRqw==
X-Gm-Message-State: AOJu0YxO5K2tyrxIHxHtY7oNjHQPsqQbIGSnIYp5q3YGFCceq7yecjSE
 10db8lzj2v/D3PI/hoDaCOG/rARa806o5Czx4uwpyzUmeUStINM/j4xu+P6fs+y9/a+giM1nTSl
 CrTSHTG0dDQb1eyA=
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr2992730wml.17.1696438616552; 
 Wed, 04 Oct 2023 09:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUJJXqotyHNP7HsCd7fDxaSZ9OjZAo+SB22LCLJfF65YSUS6zUAOMLSf4WTvEftkBB1L1YtA==
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr2992711wml.17.1696438616268; 
 Wed, 04 Oct 2023 09:56:56 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d6843000000b003143867d2ebsm4406306wrw.63.2023.10.04.09.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:56:55 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 40/53] migration/rdma: Convert qemu_rdma_write_one()
 to Error
In-Reply-To: <20230928132019.2544702-41-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:06 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-41-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:56:54 +0200
Message-ID: <875y3mtjft.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> qemu_rdma_write_flush() violates this principle: it calls
> error_report() via qemu_rdma_write_one().  I elected not to
> investigate how callers handle the error, i.e. precise impact is not
> known.
>
> Clean this up by converting qemu_rdma_write_one() to Error.  Bonus:
> resolves a FIXME about problematic use of errno.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


