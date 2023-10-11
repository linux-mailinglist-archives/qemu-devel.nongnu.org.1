Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF197C54DD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYwP-00074k-Im; Wed, 11 Oct 2023 09:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYwL-00074a-N8
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYwK-0000i3-1E
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697029670;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Mrl9XlW58mtFgWekwxZl27ErRW4BsChCf9j1XlI0vVA=;
 b=HCCHX3FBIcYx3hX9pyJErcbOaThOTX5oYWvkzIWDSMG+R87/bfo7zAGn1iSectdOwRUzO/
 F90x6LJom5GIH4LPyyaTe3xs/qerYEV4vBLJH5+xGgiyHdkztFCNvkmutV4rjLehiVwuU7
 A673gZxCpUwLPlKaDw49txpaWUOgUkk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-dsttOYpNPMqTdMOZJtRA2A-1; Wed, 11 Oct 2023 09:07:48 -0400
X-MC-Unique: dsttOYpNPMqTdMOZJtRA2A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so441938f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029667; x=1697634467;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mrl9XlW58mtFgWekwxZl27ErRW4BsChCf9j1XlI0vVA=;
 b=Zy+D24x1ladGTcdywU7ecDvADlpIkrDqm/oNPtOHPuwIj9/ZsVTV7EhHHbw/GuvuVl
 DpV9BKW7Kz946wIMtf8wynNGl7RqJnoqP33IB7bqiAh7JWhQY8/zlXlr+cM438iwwzDt
 fUvICQYnxPQcEOU9QIdm033MSPbJKmiviRzjrpoly9RnlRuwOhg8OTGJMYrDufVJI9ki
 NOnFU6bC2dy5b4svLWmNoepE2JVuYaR2UGGnbLXbd2ezJRVDi3lY8CVACgm+Ly/Ff8I+
 VvvaE/aI3kgyf410eeIXb+t7Y/p164lYgAK9k+ZYimAa0Vh865nu1A3qmicP/05gkD8Q
 9xGQ==
X-Gm-Message-State: AOJu0YxPCUlneNqqxOi6KY8TxmvF8ZPCgFP/ySBaLE7nYAHBvzBUrZ/W
 RDjXj1bvfMJcH7vxNxek0J3K6YLZMv5srXBmsqthcZOJQA5qZ3NPRY4xbz7MbP2EJBmJcaPUZNY
 fuqkebM/WOZR10cY=
X-Received: by 2002:a5d:500d:0:b0:317:dadc:4a63 with SMTP id
 e13-20020a5d500d000000b00317dadc4a63mr14924391wrt.8.1697029667620; 
 Wed, 11 Oct 2023 06:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdsto9em0ZjmIsvt2zjNNVafMf4MWNIpoDYlH3KZ5zrNMYCRn0peG+DUyEGNnoD19l1JGTww==
X-Received: by 2002:a5d:500d:0:b0:317:dadc:4a63 with SMTP id
 e13-20020a5d500d000000b00317dadc4a63mr14924369wrt.8.1697029667345; 
 Wed, 11 Oct 2023 06:07:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s17-20020a1cf211000000b00405623e0186sm19184211wmc.26.2023.10.11.06.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:07:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>,  qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
In-Reply-To: <20231010104851.802947-1-frolov@swemel.ru> (Dmitry Frolov's
 message of "Tue, 10 Oct 2023 13:48:53 +0300")
References: <20231010104851.802947-1-frolov@swemel.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:07:45 +0200
Message-ID: <87il7db93y.fsf@secure.mitica>
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

Dmitry Frolov <frolov@swemel.ru> wrote:
> qemu_ram_block_from_host() may return NULL, which will be dereferenced w/o
> check. Usualy return value is checked for this function.
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c7c0e72408df5e7821c0e995122fb2fe0ac001f1 ("migration/ram: Handle RAM block resizes during precopy")
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>


