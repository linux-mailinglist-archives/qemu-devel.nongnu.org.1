Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C3714C96
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:59:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eJg-0006jj-A2; Mon, 29 May 2023 10:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eJd-0006jb-BP
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eJb-00070e-JQ
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685372261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO4tLmVrwYAoBqEa0jlJFfvLgTHjdu8h3SyzuGVTdBU=;
 b=Lh2/8Fl0drhBDC77PI6QGsys9JqggjeKrotgGbt6nry89WRpurldzWgGzCv/G4pgd9gZt3
 MKMHEyzrd3t+vMNMWlUVKljjmoUX6YDvyC+9B2t7ejIbdpwgF3U+/VXhyLkj8/8IsrweEW
 Ub7Dkly2RIiTDP99TCpvzLkp9M64w0M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-22N3k3Z7Nna83JzNuTB7gg-1; Mon, 29 May 2023 10:57:40 -0400
X-MC-Unique: 22N3k3Z7Nna83JzNuTB7gg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-626204b0663so1998976d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 07:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685372260; x=1687964260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UO4tLmVrwYAoBqEa0jlJFfvLgTHjdu8h3SyzuGVTdBU=;
 b=hNZS6GplH/jGMzvmmmBAQdSHUBDBC9m2gI67uicYrMfy3+tFaxZpgHY0qslzkj0awd
 qM3JmEMudRedpDgL8OiICvKVhnFgK/8XVfeIV5sj6fjd2A+jJ+7PBp2RJPZqo+Ib1EHA
 g46Byc2z64yWJ0Q+l+iY0NZwkbYlxFzWfbrCvxZXsxtTM7/ouMKxVD8IN4xuw7jb9EhM
 I3mSKzPT9ryLiPSa+lXzpTG7HH+ddXFVVG+R0w1oouKwxsd9SHpghddh6mbgpygCgMQZ
 N91D33svUKJpzFwqXzGjAUpEozuKTJRW2BPLEYpjgpHOyHBYaGBqO4Iy3S7Szkd99RtW
 FDvg==
X-Gm-Message-State: AC+VfDwsjFzh/8aIWoUTNBly0JH547LFjrHD4V9eLMH93m+aj414Fg8T
 jNoTCmRfCmTZUtsIPAJIjv4uUohdV/d/PnP5ehXJ2rkw/TKO3RqVTFA1EaCHGGst8g35r/2WZqA
 zvdi2VLRRbyBUK3o=
X-Received: by 2002:a05:6214:528a:b0:61b:2111:c2e2 with SMTP id
 kj10-20020a056214528a00b0061b2111c2e2mr11804868qvb.2.1685372259918; 
 Mon, 29 May 2023 07:57:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75puNAAJ+9wAs46FAbQWVGC9b5P3Mgr6XYYmu8/jAFh/zwP9Rr5qAhftu+gj5lWDYd4P+CHw==
X-Received: by 2002:a05:6214:528a:b0:61b:2111:c2e2 with SMTP id
 kj10-20020a056214528a00b0061b2111c2e2mr11804846qvb.2.1685372259588; 
 Mon, 29 May 2023 07:57:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 e16-20020a0cf750000000b006257e64474asm1526618qvo.113.2023.05.29.07.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 07:57:39 -0700 (PDT)
Date: Mon, 29 May 2023 10:57:38 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: fix migrate_params_test_apply to set the
 dest param correctly
Message-ID: <ZHS9YgSA5Jggd7ay@x1n>
References: <20230524080157.530968-1-wei.w.wang@intel.com>
 <ZHEpYQ01D7O3MQqM@x1n>
 <DS0PR11MB6373304AA3B38CBB22D22BADDC4A9@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB6373304AA3B38CBB22D22BADDC4A9@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 29, 2023 at 12:55:30PM +0000, Wang, Wei W wrote:
> On Saturday, May 27, 2023 5:49 AM, Peter Xu wrote:
> > On Wed, May 24, 2023 at 04:01:57PM +0800, Wei Wang wrote:
> > > qmp_migrate_set_parameters expects to use tmp for parameters check, so
> > > migrate_params_test_apply is expected to copy the related fields from
> > > params to tmp. So fix migrate_params_test_apply to use the function
> > > parameter, *dest, rather than the global one. The dest->has_xxx (xxx
> > > is the feature name) related fields need to be set, as they will be
> > > checked by migrate_params_check.
> > 
> > I think it's fine to do as what you suggested, but I don't see much benefit
> > either.. the old code IIUC will check all params even if 1 param changed,
> > while after your change it only checks the modified ones.
> > 
> > There's slight benefits but not so much, especially "22+, 2-" LOCs, because
> > we don't really do this a lot; some more sanity check also makes sense to me
> > even if everything is always checked, so we'll hit errors if anything
> > accidentally goes wrong too.
> > 
> > Is there a real bug somewhere?
> 
> Yes. Please see qmp_migrate_set_parameters:
> 
> #1    migrate_params_test_apply(params, &tmp);
> 
>  #2   if (!migrate_params_check(&tmp, errp)) {
>         /* Invalid parameter */
>         return;
>     }
>  #3  migrate_params_apply(params, errp);
> 
> #2 tries to do params check using tmp, which is expected to be set up
> by #1, but #1 didn't use "&tmp",

#1 initialized "&tmp" with current parameters, here:

    *dest = migrate_get_current()->parameters;

?

> so "tmp" doesn’t seem to store the
> valid values as expected for the check (that is, #2 above isn’t effectively
> doing any check for the user input params)

Do you have a reproducer where qmp set param will not check properly on
user input?

> 
> The alternative fix would be to remove the intermediate "tmp" params,
> but this might break the usage from commit 1bda8b3c6950, so need thoughts
> from Markus if we want go for this approach.

Thanks,

-- 
Peter Xu


