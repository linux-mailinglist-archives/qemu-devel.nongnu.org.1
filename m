Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB97B9B5A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIjQ-0006NL-MA; Thu, 05 Oct 2023 03:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoIjN-0006N8-Dg
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoIjK-0005O5-Tb
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696490705;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6WCxDT/nsuuAINFP+OrMOvhGfO3IaQS6CQWgKVaSy1k=;
 b=IG5N93yL5d0XipF3Z5SlZxsWW6UJdBGkLiTpXBVWKPbLEuwqLitOBZrylArQqdQrMq3+f9
 sk2TavWzQlBhiheoCu7e8mVwXd3O0O+M0Ho0QkS2MesDa85KQR64NJWxiDvohS5lYo6RIU
 ZjfFiAmLdHVzqWoicRwC7HeUB6x8p0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-sSbWAMwyOZGKargfksVFGA-1; Thu, 05 Oct 2023 03:24:43 -0400
X-MC-Unique: sSbWAMwyOZGKargfksVFGA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso4855565e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696490682; x=1697095482;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WCxDT/nsuuAINFP+OrMOvhGfO3IaQS6CQWgKVaSy1k=;
 b=YZygLQc6xqxeqAmGpERst89mRlOnDppJBkDBHCENpckvHBBNyTKhRdcpPrz2xfLHT5
 2bZPBWOa6ax7wtXW81hd1+j5CCID9kZxkvo6qaGlFlGyZ3AYPl+wrYyXDXLCTKaznJnS
 mwWg4nxSxR1kYkYIr8uM2juxIh3s1kHLj2rOTfMxu0RbjkKIGqQ5s94ZBG1C4KE8Leoj
 lcCrtZWG7FW7lIjsuAxJFSXbR+NDfi0m2cLIfquVwu84vXsmeGN9tuFDCnZ72NCDK5NX
 lWcQbILsAaO8/iv9+PA8at3rCYu7eur66ENN7/+b9aaiS5gUmH1uMiPgfb8qWPzDcR29
 vEBQ==
X-Gm-Message-State: AOJu0YxdLpJfyLwlt4WYMBdD+DhSKg/QwEenQmQkZwyZIWuZ8jbhFNTY
 1yxQ/cqKqtVLHFxYtCU4CdHjDOZRE27XtyIgK20qLTAc/fK+yhJ0nPxOebW0WI9GspDz+xteCVJ
 pGXiCsw8O3H/EZQ8=
X-Received: by 2002:a1c:6a0d:0:b0:3fc:1a6:7764 with SMTP id
 f13-20020a1c6a0d000000b003fc01a67764mr4115995wmc.16.1696490682206; 
 Thu, 05 Oct 2023 00:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfcsEbd2cKEQFPn5Tef/qPUrVJ/ZuL2s9nDHtRPCh4tRLIA+4OZza/0ja0Z29FuLkfMg2CKw==
X-Received: by 2002:a1c:6a0d:0:b0:3fc:1a6:7764 with SMTP id
 f13-20020a1c6a0d000000b003fc01a67764mr4115976wmc.16.1696490681849; 
 Thu, 05 Oct 2023 00:24:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b00406725f27e1sm837428wmc.42.2023.10.05.00.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:24:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 52/53] migration/rdma: Use error_report() & friends
 instead of stderr
In-Reply-To: <20230928132019.2544702-53-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:18 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-53-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:24:40 +0200
Message-ID: <87wmw1pm4n.fsf@secure.mitica>
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
> error_report() obeys -msg, reports the current error location if any,
> and reports to the current monitor if any.  Reporting to stderr
> directly with fprintf() or perror() is wrong, because it loses all
> this.
>
> Fix the offenders.  Bonus: resolves a FIXME about problematic use of
> errno.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I fixed the WARN issue by hand.

Reviewed-by: Juan Quintela <quintela@redhat.com>


