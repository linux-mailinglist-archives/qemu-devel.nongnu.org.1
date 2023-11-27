Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A947FAB4A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:24:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7i8M-0001Y0-Sk; Mon, 27 Nov 2023 15:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7i8L-0001Xn-Ca
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7i8J-0001ic-Tx
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701116586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c538PmiR9ahVj+eyGMW25DBp+plFfH0GMFxcSIAFpG0=;
 b=ZQIlJT8lGS0U3JAzCDXiHUe6nnzoZHz8wtT+y4pwaeNCMKqiznAIVFhSBR+vWHsiBYoQXL
 Hj6I1kGYF7UX9pXARv/mFMCVRcuuIsVyr7pyK3PILN1rUF3uhksmUPquLwMkBFnSX6RAxc
 8CCaQ4oAAcjH0VZJ2TiRVyvVByEdjqw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-j_EBToKaOJGD3MZf1_LrAQ-1; Mon, 27 Nov 2023 15:23:05 -0500
X-MC-Unique: j_EBToKaOJGD3MZf1_LrAQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67a542b737fso1213276d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 12:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701116583; x=1701721383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c538PmiR9ahVj+eyGMW25DBp+plFfH0GMFxcSIAFpG0=;
 b=gnJJTdeT83+V3ZPHjYKXMUWPvhyeeTe0ixWh4DI2hDPW71L0EfJmu/CrKSgABGSwY5
 a0UlVNW0Jnx3Ljj7EVCQlLdMA/Ha53SYF1NQ3e4vCMGNYI0fzKSeQnMasNlVEFolwjMq
 zbX9/7Ti8yiBZnyijOdx2/EC39kUz3ieZfzalQPsjLLgpL/lfkIV18fx59CFzFyDmfs6
 wYXtY3mzNrjtX2gcu3gbYXPNMUmKsSejcyZPFm7jXF/f5EL4UqBQGn9ciYRODn1wN401
 qpwBn4RReu5gPwJk6My+KYru334t3e8u5IJeub3yQRGfBgQrfZy/+1nmj8RZtT40xoJT
 PNxQ==
X-Gm-Message-State: AOJu0YxXKFIB3UZWnfa2YSpM3qj005DDlJjyBYjCTKMsQf0ilX2mtnhV
 tmadwmt+InyDEEOBCf5H+LquR6THnDu9v73x1rk5N6vWm+K1ExeWBOh6Hlpn5O/6F+es6XjdRrL
 332Zs0Mv1kgomK1I=
X-Received: by 2002:ad4:58ae:0:b0:67a:29c7:98cd with SMTP id
 ea14-20020ad458ae000000b0067a29c798cdmr8836052qvb.4.1701116583580; 
 Mon, 27 Nov 2023 12:23:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1kxv8LUCBapbe4POntyJvC4XtQlIQyXMyk3oXnDdaMjGzMyp4vaDRmOvi0a6zKjMLP5f1AA==
X-Received: by 2002:ad4:58ae:0:b0:67a:29c7:98cd with SMTP id
 ea14-20020ad458ae000000b0067a29c798cdmr8836024qvb.4.1701116583301; 
 Mon, 27 Nov 2023 12:23:03 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 dw12-20020a0562140a0c00b0067a1c7d8e98sm3315000qvb.41.2023.11.27.12.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 12:23:02 -0800 (PST)
Date: Mon, 27 Nov 2023 15:23:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 5/7] tests/qtest/migration: Print migration incoming
 errors
Message-ID: <ZWT6pCri-NmPy3Bt@x1n>
References: <ZWSswkonmoz2ryQu@x1n>
 <87ttp72ny1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttp72ny1.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 27, 2023 at 12:52:38PM -0300, Fabiano Rosas wrote:
> >> @@ -118,6 +118,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> >>  
> >>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
> >>                      args);
> >> +
> >> +    if (!qdict_haskey(rsp, "return")) {
> >> +        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
> >> +        g_test_message("%s", s->str);
> >> +    }
> >
> > This traps the "migrate-incoming" command only (which, afaiu, only setup
> > the listening), would this capture the incoming error?
> 
> This is about the migrate-incoming only. We could replace "incoming
> migration" with "qmp_migrate_incoming" in the commit message to clarify.

Ah.. Did you ever see this failure in any of your runs in these tests?  I
think it means you hit the assertion right below this part, but I'm just
curious how, as the URIs in the test cases are pretty constant.

-- 
Peter Xu


