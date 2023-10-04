Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA77B8457
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4Ew-0007Oz-UD; Wed, 04 Oct 2023 11:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4El-0007Of-B5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4Ei-0002oj-QY
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696434991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/qR3kpF5/jDDQ+otErZX4MHBSFTOMipl7J2vmbSwS7U=;
 b=G8hvSWuFCPfGKjjyf3TYcVcInLLXWLDhJ1BNvywXvNfVLn/cYIrwq20f/SIznwlE+J3rRk
 kbazcRLxIEzXm+goqVVg3JCy555x4+Q4FZu/pDN8fMC4B6eLT48JLMuAlVQCzsfq8DDycQ
 bTMRn0K/FX/dgJnLOFLz0nIaqt7wLKw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-8wceV_sfM1K1jP16zfcO-g-1; Wed, 04 Oct 2023 11:56:30 -0400
X-MC-Unique: 8wceV_sfM1K1jP16zfcO-g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405629826ccso17774855e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696434989; x=1697039789;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qR3kpF5/jDDQ+otErZX4MHBSFTOMipl7J2vmbSwS7U=;
 b=wfRh8+aO0m50NKpcA9P3KlymnVS9fjjJcoUTbnLMfTLluJZoktT9JMcJKtwJb4FWY3
 bJYuK1uOIKSmRkFNvWWQCIykblhKsO0cfyRNE/isy7Dye5TcKPRNGSAZuVN7DdYSscob
 yPcx2MXSmLimVVayE3spoB/U149Q9z8u2/XQv88KXEiNdBVOm/NLslQg7NZGQVhQwyUY
 DfI6FfAhgBVEYOaUbdHAeocxPzAua8MzUv8zms0oP5604ui0xizYKX0MZ7/QBf3+xUBv
 Tc71qzduKQwgGHeKHKYo8B7SWL5abeKlR2FO+H3+736wEvV5h1ApAIoixHreSyOiJCLt
 lnPA==
X-Gm-Message-State: AOJu0YweG0amEN7A1dGqjyNXKCa0DumdD1A+p3FYgDiC0PNpmeB2XZVV
 S2/0gF0hRevwxLWgvWHCsdmvc/eg9ulwJcJ4N/xDUl6NdEzW7KOhtz4BmaMBo+EF9s/EVsZ3/lC
 mQeIkBWIeE/nWRY4=
X-Received: by 2002:a7b:cd11:0:b0:405:40ec:415d with SMTP id
 f17-20020a7bcd11000000b0040540ec415dmr2559114wmj.39.1696434989546; 
 Wed, 04 Oct 2023 08:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC+1PFz9/tvHXFiwK7Ir1nv6PH4KvzPfvZYmGK7h8Hjicv7IJfvtZCFbvdcgnTPDY/3taSWg==
X-Received: by 2002:a7b:cd11:0:b0:405:40ec:415d with SMTP id
 f17-20020a7bcd11000000b0040540ec415dmr2559095wmj.39.1696434989245; 
 Wed, 04 Oct 2023 08:56:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m9-20020a5d6a09000000b003232380ffd5sm4299856wru.106.2023.10.04.08.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:56:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 15/53] migration/rdma: Use bool for two RDMAContext
 flags
In-Reply-To: <20230928132019.2544702-16-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:41 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-16-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:56:27 +0200
Message-ID: <87il7mwfdg.fsf@secure.mitica>
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
> @error_reported and @received_error are flags.  The latter is even
> assigned bool true.  Change them from int to bool.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


