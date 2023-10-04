Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C87B85E5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo58j-0005K0-LA; Wed, 04 Oct 2023 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo58F-0005FD-46
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo58D-0008Ql-1T
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UXZi8zoHsELb3lyKvst+j86iv6Ov+G2OFUNZA+wu0ew=;
 b=iSlWEy2kBV7EPft1rL1lVLJ02Pvkru8JUnkHJ8Dw5EWymQte/jNn+HJPjoEkZ/jUTa/o6Q
 qbcXOle6c6FSqhm+WRIpzDR09hB7Uiu9vlYVxxtxSZySGb996EZktcbjJ5M0XA0t9WZK+m
 BdcSmeCf1tlqC13+NJNmDD4kraAa75s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-VTRoAa7XMRO8GL87YCXgCQ-1; Wed, 04 Oct 2023 12:53:46 -0400
X-MC-Unique: VTRoAa7XMRO8GL87YCXgCQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32323283257so41965f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438425; x=1697043225;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXZi8zoHsELb3lyKvst+j86iv6Ov+G2OFUNZA+wu0ew=;
 b=HOPtujd1be9BPEYtW/qOroraHXvpNUljHykB8RxHdXkFmmujnYj6iIXea1Z+hCtvkW
 cvJdaRU5HU1+mOrZ4DJISb7lV9xY9uW5s7krR2DTwwAOswTC3lXtafAQQBZlI9c9ytxF
 OxaSVWLOkSwEcypjZsXChM/oGbxOBzYVwXAmrPp0bh9oZqbOhlWFbedfRqgPw4gKYy/s
 LrjA+HzI9bl5vFvTMCZqo0vXBlHZiSU2dXY9VDl+4HVWKisFNTeyUYpIGCHagfjYJfZw
 tMwIAkkv62AK927eMAV5Kdvnr0nC7ASZeicRfSFX0Sr/q8mWHoe12hy5I5dzX031cDqM
 ejtg==
X-Gm-Message-State: AOJu0Yz5WdItltjX7fgyn/VqB4/7p8CtIDeTWHdgR4iH6FSp1Cg0RvXr
 ChpNFhEmpb9g9Dq+YCaD/qT0MPbhTYWIg2QnBcsBsDyriK35VHWB950Ghxxt0Iak9/LglK/4PVW
 x0WZeIKWSyn60mUA=
X-Received: by 2002:adf:f585:0:b0:322:7174:7d28 with SMTP id
 f5-20020adff585000000b0032271747d28mr2620524wro.55.1696438424993; 
 Wed, 04 Oct 2023 09:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERF43VzR3cFmw5jgcOzRh5Ol/DKZeoHyL0gNP435BVtmsrTnxin0W4+NLt6i0gPt1KZ40PWA==
X-Received: by 2002:adf:f585:0:b0:322:7174:7d28 with SMTP id
 f5-20020adff585000000b0032271747d28mr2620510wro.55.1696438424775; 
 Wed, 04 Oct 2023 09:53:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d570f000000b003217cbab88bsm4393894wrv.16.2023.10.04.09.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:53:44 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 35/53] migration/rdma: Convert
 qemu_rdma_exchange_recv() to Error
In-Reply-To: <20230928132019.2544702-36-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:01 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-36-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:53:43 +0200
Message-ID: <87r0matjl4.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> qio_channel_rdma_readv() violates this principle: it calls
> error_report() via qemu_rdma_exchange_recv().  I elected not to
> investigate how callers handle the error, i.e. precise impact is not
> known.
>
> Clean this up by converting qemu_rdma_exchange_recv() to Error.
>
> Necessitates setting an error when qemu_rdma_exchange_get_response()
> failed.  Since this error will go away later in this series, simply
> use "FIXME temporary error message" there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


