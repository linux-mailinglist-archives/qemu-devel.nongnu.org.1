Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C171F805A81
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 17:52:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAYdL-00052R-U7; Tue, 05 Dec 2023 11:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAYdC-0004tJ-2l
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAYdA-0001Va-6z
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701795019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHTNCxHY30RzmYzKOd1HgwM3ff2JNne4bhBklDqmqsQ=;
 b=J9YGCHK9KouXPDjEWX7kXBqQsuTebWLw5apadLFro4eqlhYdc4tLdUWYWtUgPUKD2NyCVb
 4uEardSz9uMacxIjaFzFCRs5htDe8IN4C4oNEXk0AetoYrzbUQTD+n6LyI7EwA1Pr83i1n
 wyyz330SpVsK1YMlefdsyzbpHJujIBM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327--nOp5YjHPl2CSlIP9VA2bg-1; Tue, 05 Dec 2023 11:50:17 -0500
X-MC-Unique: -nOp5YjHPl2CSlIP9VA2bg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67a89c5eae4so5679506d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 08:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701795017; x=1702399817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHTNCxHY30RzmYzKOd1HgwM3ff2JNne4bhBklDqmqsQ=;
 b=JkSGtmmxuCGGavmX91YPaMkRtnASxmZssjbD1l+XIOGFRGs2iAgUfyTwG2gy7VazW+
 i/YuOKnRKfQJT4vKMH4FZBRp9dC2HJ+DX4N8Vw5zzJgYf5loiS40IIkFFa9sVI6daoyS
 5jXroXwrGppLO6jHQooKCMYw0zMu9FOvl8knLCCUCc0lNAXVCinzliBKgxSRYtE2Mxrl
 oBlCXOkFrkIrduF91af0IWhupYj9xujkfG2QYho3QnjcPoBTokBflVld9A0K4o+86Yeh
 Gq8dQv9XuELFL3Vg8XNFo81Sfy7mEkrZExSxtwd8P2PICgg77gnDhAMYm5KFGTJI8h63
 FK+Q==
X-Gm-Message-State: AOJu0Yyszz5qlyO7k7DtKGBoPTrtG76taJqVjOcGTkZLEeveWNJea3Z0
 1P/BSKRA1kh5Z/39M+FdX+F+y7yTBqRnC4ensdBL96z/uDLQaQlCkvrKT7Dx4IThARzGa9k56Kp
 oooICIoEZ9NhluGc=
X-Received: by 2002:a05:6214:1fcc:b0:67a:1ba8:4882 with SMTP id
 jh12-20020a0562141fcc00b0067a1ba84882mr16532346qvb.5.1701795017224; 
 Tue, 05 Dec 2023 08:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjgbH8Kg6IbpyiqyMBbYWO3oMhhwz1jG22PQ9gBYoFJk9wd2z7fv7xaCgJSpiwalAUkBpZ9Q==
X-Received: by 2002:a05:6214:1fcc:b0:67a:1ba8:4882 with SMTP id
 jh12-20020a0562141fcc00b0067a1ba84882mr16532338qvb.5.1701795016939; 
 Tue, 05 Dec 2023 08:50:16 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k23-20020a0cb257000000b0067a53851126sm5315610qve.98.2023.12.05.08.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 08:50:16 -0800 (PST)
Date: Tue, 5 Dec 2023 11:50:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Message-ID: <ZW9Uxpcc5RO-m3l9@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n>
 <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n>
 <38a8b047-4c60-4e6f-9ccd-a307d0358f53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38a8b047-4c60-4e6f-9ccd-a307d0358f53@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Dec 04, 2023 at 05:23:57PM -0500, Steven Sistare wrote:
> The V6 code does not pass a state to vm_start, and knowledge of vm_was_suspended
> is confined to the global_state and cpus functions.  IMO this is a more modular
> and robust solution, as multiple sites may call vm_start(), and the right thing
> happens.  Look at patch 6.  The changes are minimal because vm_start "just works".

Oh I think I see what you meant.  Sounds good then.

Shall we hide that into vm_prepare_start()?  It seems three's still one
more call sites that always pass in RUNNING (gdb_continue_partial).

If with above, vm_prepare_start() will go into either RUNNING, SUSPENDED,
or an error.  It returns 0 only if RUNNING, -1 for all the rest.  Maybe we
can already also touch up the retval of vm_prepare_start() to be a boolean,
reflecting "whether vcpu needs to be started".

-- 
Peter Xu


