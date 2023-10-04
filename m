Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C57B85EB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:56:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo59s-00017H-EM; Wed, 04 Oct 2023 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo59o-00012B-AC
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo59i-0002KH-56
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jbR6VgRgYjr0EiyjZBOco965j2p1djrM8RjeAO093V4=;
 b=hXTjYtNPiy4SpBYhiKstTV/Tqpb1R1WaGASBpNiOr0d+YJjWq3m1DEIv7iD8wsep+IdU78
 JqJTVZ1v3O/hEVZu2Hhd7tQcZrsKftKvrvdHvYBfkzlh+uH4yb0OBPLL+jnRdDa1xboct6
 c/+qC9Nh4eU5+wLgvN7hK3VYxlYR3/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-zqKUPN5sOkKcI-KdYWuMXg-1; Wed, 04 Oct 2023 12:55:11 -0400
X-MC-Unique: zqKUPN5sOkKcI-KdYWuMXg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32323283257so43006f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438507; x=1697043307;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbR6VgRgYjr0EiyjZBOco965j2p1djrM8RjeAO093V4=;
 b=S86pVDxAheeBwwX4bL0Vgru3qXuDmaskZOZ6ZCkntLHvDAqNoeaIIBIxG+xNIR2CnR
 MxbEgKeMEVM6hifbuA8VjQRu0Nk274MFXJHTi+lIGgtAU5J74QVN71pbx2ZMoYeJryl2
 y678D+vMQULsVQ3TXGuD91VTFi3fqolSFgQGvMTgKTBX896E6DYnNLKJrHGcGi4tA7B2
 HhH3TOxKZ2e2IeqmGdMzdZKefJgS98OrhOQysJJrxF/yEUdHBIoDebLJs0ol+H5GbBZc
 b/2jfqATzVAFzm3+6bVxzxBKLmi/esVsJZVwSLvh1bjgBeVxEr6HfG6e4hhx6OUwzAOh
 KJxw==
X-Gm-Message-State: AOJu0Yz9pYlTJvLhBL6ATm0agJeurZo2ztfHva3I4jFKIaCk7fpMrot/
 zl2s0TOakjRKtxJE6AH2xZ10IkSPMP9rt5+knWw8QybXX4gkUwdw3keYNQOzLheNxQJmhmAMh2l
 vDp1DxtHZO33hiJU=
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id
 f7-20020a0560001b0700b00321645062eamr2773117wrz.36.1696438507165; 
 Wed, 04 Oct 2023 09:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQSUan5OS4F1qcQdxY6arw3vIkguVjRCJv01EHcxXrf8Wo4y4Zwl6sOYiZL1j1A54AQhp8TQ==
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id
 f7-20020a0560001b0700b00321645062eamr2773105wrz.36.1696438506874; 
 Wed, 04 Oct 2023 09:55:06 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b00318147fd2d3sm4435988wru.41.2023.10.04.09.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:55:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 36/53] migration/rdma: Convert
 qemu_rdma_exchange_send() to Error
In-Reply-To: <20230928132019.2544702-37-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:02 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-37-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:55:05 +0200
Message-ID: <87mswytjiu.fsf@secure.mitica>
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
> qio_channel_rdma_writev() violates this principle: it calls
> error_report() via qemu_rdma_exchange_send().  I elected not to
> investigate how callers handle the error, i.e. precise impact is not
> known.
>
> Clean this up by converting qemu_rdma_exchange_send() to Error.
>
> Necessitates setting an error when qemu_rdma_post_recv_control(),
> callback(), or qemu_rdma_exchange_get_response() failed.  Since these
> errors will go away later in this series, simply use "FIXME temporary
> error message" there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


