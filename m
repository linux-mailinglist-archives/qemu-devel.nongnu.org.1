Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A217B84E1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4bs-0004C0-Qo; Wed, 04 Oct 2023 12:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4bS-0004Bc-8x
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4bQ-0003S2-M9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436399;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XEFrc28FGMOPgViS8SDi6vrZa/x32Sert+ujjCeK9as=;
 b=U/YmRxk8WwlL5NTaPvkQ8Va6NNuAfrwUX8skRh3unKNF6kzum4rieRejYpcojjei69jeVm
 ndOCgLrRNGzzMMk4dgws/1VP4kFG1QkrEDq7K31W6gmjpj5vCGGKjQukcs3FVGheTyS6MP
 Ud1vCE+nsylYECLfqvo19n/qppVnTLc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-1Dtx82CBOaGI7QoJgjDcTQ-1; Wed, 04 Oct 2023 12:19:47 -0400
X-MC-Unique: 1Dtx82CBOaGI7QoJgjDcTQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40590e6bd67so17004835e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436386; x=1697041186;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEFrc28FGMOPgViS8SDi6vrZa/x32Sert+ujjCeK9as=;
 b=YYImt8B1udJeiVSpF0a901ZPlbl+hJ0QKctUIbsPr7PTZEbjQDhV4RUDgLMXJRsAj0
 jEAzgXrmPKXZLKtOSZK8cKKZCR68WwWuDkWPDaMNLXP7BjHs0vy7khV/rPTtfDIwqGYC
 O1Vv8sxA2MnRtAu0jtKbs6dWsORBIB6PYKpaXAPEwSJpddlCR3Bqf/rVHHAmsY2IxnwS
 i7ClbhurwpDBH3K3lrPx3CvcjQJOu82IdWQnLJ8Si0UdI43IN2F7v1vPN8j9vDMPNztD
 b/sdP7SpIWAEo+hgTwStZOHU/7srFTO3uPH+pHixjLl9pCkpIQ0kw2abpEe5oAToyUK8
 sYwQ==
X-Gm-Message-State: AOJu0Yyhkgioeo4QUS6ShGJwiLlhgbDAE+tGqBW84Rp0PKLflTkVqi7u
 XjNPHuKlN/C9lfirhetTkNNR6AfnuY5uUDBY07RSJ02aYsBmcnh6ndpJcYq36XQbgwMYk2hOu7J
 6AlhkThT7jeEahUQ=
X-Received: by 2002:a05:600c:204f:b0:3fe:3004:1ffd with SMTP id
 p15-20020a05600c204f00b003fe30041ffdmr2938175wmg.4.1696436386385; 
 Wed, 04 Oct 2023 09:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0hl7r/M4k4hF+1zIDFObf58jNPOK9LoLcLbNFyhnYfv4kKOGw+xihKNrhu49ksOEteM7IDw==
X-Received: by 2002:a05:600c:204f:b0:3fe:3004:1ffd with SMTP id
 p15-20020a05600c204f00b003fe30041ffdmr2938156wmg.4.1696436386032; 
 Wed, 04 Oct 2023 09:19:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 15-20020a05600c028f00b00406443c8b4fsm1904775wmk.19.2023.10.04.09.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:19:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 25/53] migration/rdma: Return -1 instead of negative
 errno code
In-Reply-To: <20230928132019.2544702-26-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:51 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-26-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:19:44 +0200
Message-ID: <87ediawean.fsf@secure.mitica>
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
> Several functions return negative errno codes on failure.  Callers
> check for specific codes exactly never.  For some of the functions,
> callers couldn't check even if they wanted to, because the functions
> also return negative values that aren't errno codes, leaving readers
> confused on what the function actually returns.
>
> Clean up and simplify: return -1 instead of negative errno code.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


