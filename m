Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B67087E6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 20:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pziVG-0007CE-Cq; Thu, 18 May 2023 14:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pziQE-00067r-BP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 14:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pziQ7-0004gN-EQ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 14:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684434729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y9h8PiUKlX/qQMuh2iXjjxhJSJs4QIbitm8N13sGurg=;
 b=idrcSg408S7b09s4nhBGCH3YgJNdvLegQW4ij+A4pghc7f8s/7DoLX2q4q3zSXwobqx59N
 9pFBQ1c20c8/UjLwQB+wkG0hOZlcunKV+1eFjQfZGcshhGh28Jn31By2OyBH2naVWLJVlR
 90+n+Gt+sr9PKzrXVqHpHbTdzOVwMqo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-O6DYbdg9OGqP3uc2QMPN3A-1; Thu, 18 May 2023 14:32:08 -0400
X-MC-Unique: O6DYbdg9OGqP3uc2QMPN3A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f386bb966cso2096131cf.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 11:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684434727; x=1687026727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9h8PiUKlX/qQMuh2iXjjxhJSJs4QIbitm8N13sGurg=;
 b=DUE3VLSRXUCGaDB4KQsdhqbNBVCJO9j69x9CtX9Eof2VB1H/cPq0Z4YOAE0EK1GdYx
 jhdFIs29zklRxVO51vTm3yVu9r4Jkgtn/qvnoEvNfY+JdIlHjIyDlf/edsdNeH3OuYwn
 4drDImnUP4ZSxReQiLzkYeDxFOa/oYZ4nS9OChlTltZrpvcK31tEhx0TgreYUb3Y0QtM
 xdMMpfQihen4cG85ebhWEXZMkbe8+QZl+u+OvoEBOI3cm7THPf/S69zhePyq66V1sKhR
 OleXFmUZWGds5mge/6Fy9m4C6b9VLU7nqTNNHq/QS22r/XzI//qZB2MyDa8LsUfcpdcP
 LsPA==
X-Gm-Message-State: AC+VfDxkvbg3vzItrlBTNq+3mDCr1znqBdMDRM5lNiUZE1/x+uPrmnp7
 fZfTo1+AMF/z7UDWoo0RZooJuYLsHkBk9bMxeklwl4F6eUGrXV5wV7Oqi/7DAFEmCPpE+LnPW4T
 8ynnY6JEKYWnpUDfaXPue7eo=
X-Received: by 2002:a05:622a:1993:b0:3ef:5587:723b with SMTP id
 u19-20020a05622a199300b003ef5587723bmr13059882qtc.3.1684434727183; 
 Thu, 18 May 2023 11:32:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ750S0RasnQ/FTmx9czDvwoCRAaCme+xW7WIFfYu+PM695jacei2+TVByhZ6LNeusOxVU8w1Q==
X-Received: by 2002:a05:622a:1993:b0:3ef:5587:723b with SMTP id
 u19-20020a05622a199300b003ef5587723bmr13059854qtc.3.1684434726945; 
 Thu, 18 May 2023 11:32:06 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 q8-20020ac84508000000b003ee2fb84d0dsm691261qtn.11.2023.05.18.11.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 11:32:06 -0700 (PDT)
Date: Thu, 18 May 2023 14:32:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Leonardo Bras <leobras@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 21/21] migration/multifd: Compute transferred bytes
 correctly
Message-ID: <ZGZvJIiX2OThDYQd@x1n>
References: <20230508130909.65420-1-quintela@redhat.com>
 <20230508130909.65420-22-quintela@redhat.com>
 <ZGZTCAHV5M/+w3VS@x1n> <87o7mhbnkd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7mhbnkd.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, May 18, 2023 at 06:40:18PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, May 08, 2023 at 03:09:09PM +0200, Juan Quintela wrote:
> >> In the past, we had to put the in the main thread all the operations
> >> related with sizes due to qemu_file not beeing thread safe.  As now
> >> all counters are atomic, we can update the counters just after the
> >> do the write.  As an aditional bonus, we are able to use the right
> >> value for the compression methods.  Right now we were assuming that
> >> there were no compression at all.
> >
> > Maybe worth mention that initial packet is also accounted after this.
> 
> Ok.
> >>  
> >> +            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
> >> +            stat64_add(&mig_stats.transferred, p->next_packet_size);
> >
> > Two nits:
> >
> > Maybe merge the two so half atomic operations?
> 
> On my tree, to send after this got in:
> 
> 77fdd3475c migration: Remove transferred atomic counter
> 
> O:-)

Ah this looks even better, indeed. :)

What I meant was we can also do atomic update in one shot for both
next_packet_size + packet_len.

> 
> > Also maybe also worth having a inline helper for adding both multifd_bytes
> > and transferred?
> 
> I am removing it.
> 
> After next set of packates:
> 
> rate limit is calulated as:
> 
> begining_period = migration_transferred_bytes();
> ...
> 
> bytes_this_period = migration_transferred_bytes() - begining_period;
> 
> transferred is calculated as:
> - multifd_bytes + qemu_file_bytes;
> 
> So things get really simple.  As all counters are atomic, you do a
> write and after the write to increse the write size to the qemu_file or
> to the multifd_bytes.  And that is it.

Agreed.

Thanks,

-- 
Peter Xu


