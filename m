Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF067B8664
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:24:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5bV-0008FD-Lz; Wed, 04 Oct 2023 13:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5bL-0008CE-VN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5bI-0005Cf-5J
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696440235;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UEiHqRJ3tdLEUvQJUnt2uDP6MLIVHQd/SxxMypq1DfE=;
 b=d3YgvEY2LPmhTdygoiptIBM/aFpU5X5D20ckPwEl+nyBK9yafsseiB+TQgIZCWP8RbXHUW
 CsnlbSmEfXa+jGsSWndxxblwhDQ1vYXvqXPYkAfaCugTcy2fDXwtdxqG3h6+btBwNaBffH
 CkbAaKU/d6zGH/1ILi3VKyLb+y+zaTc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-aKUvP1FIP6i9mjO8zYN3cA-1; Wed, 04 Oct 2023 13:23:44 -0400
X-MC-Unique: aKUvP1FIP6i9mjO8zYN3cA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405917470e8so288135e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440223; x=1697045023;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEiHqRJ3tdLEUvQJUnt2uDP6MLIVHQd/SxxMypq1DfE=;
 b=JoguBOPCs5qernmgmKsXFoz8FNCCYvpk7cm88gTb7TzqGrCMiiKD3kaj0InQnF25D5
 FShfrQTd9y4gSS+MZ2ZhsvxvKP500eUQlWMhqBiVeVYUtNR9NgtNoFfAw1/BtupDPqMT
 iX5f1NUkxkwAgQlehG3bRlweOSNOBL0ZNlnsSfW+iDA1NTDUQNWwhHs6hCoaL7HYoymB
 o4OggyOhEibsmFf/yEghCyc6tuhh7J/qpVqKKbQsEeZSH16gA90zt2AGPjieDXcPTKTP
 4ErOZbCkjigzZRvNCa7CmgcULcnIK4fj9jkMWsEFptuZ+mhhbrccjFe0asWeqUstQIE2
 jFlg==
X-Gm-Message-State: AOJu0YzJnmrmxyAxgRc+3CMtui5f/h57ivxA15kdGqk/gHcHf7jXCyc9
 vVJKncFet+FMiHqu/nArx6hgkM+gOPnTj4gG8dJdTkdfRSATx3PD3TTjC/BBg7SPol6UyvY8tBv
 sL9F9NBapN+4P6x0=
X-Received: by 2002:a7b:cd11:0:b0:405:40ec:415d with SMTP id
 f17-20020a7bcd11000000b0040540ec415dmr2772963wmj.39.1696440222888; 
 Wed, 04 Oct 2023 10:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh157w/piuR9GyKNzPLRzJqqIaO/lNMw/TZzsPIWmsyd7lU8ytVk5BGKl+RAtz1xZNbprIUA==
X-Received: by 2002:a7b:cd11:0:b0:405:40ec:415d with SMTP id
 f17-20020a7bcd11000000b0040540ec415dmr2772950wmj.39.1696440222577; 
 Wed, 04 Oct 2023 10:23:42 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l26-20020a7bc45a000000b00405bbfd5d16sm2022077wmi.7.2023.10.04.10.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:23:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 41/53] migration/rdma: Convert qemu_rdma_write() to
 Error
In-Reply-To: <20230928132019.2544702-42-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:07 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-42-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 19:23:41 +0200
Message-ID: <87y1gis3mq.fsf@secure.mitica>
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
> Just for consistency with qemu_rdma_write_one() and
> qemu_rdma_write_flush(), and for slightly simpler code.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


