Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29482B865
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 01:03:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO4zk-00008M-03; Thu, 11 Jan 2024 19:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rO4zg-00007x-VO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 19:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rO4zf-0001HH-Cs
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 19:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705017709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJdUL+Lg/0PamaK20weKlpIyGoRHMYEtQiXpU91PDpQ=;
 b=J2bAulHd5uN8CsMEbY49qRKdWXloX8C+gCVDVJhrC/7pBwFw3ST/8o3i1V/LUVSWfMBsL4
 X6SqfCm51Chpq7dmTmlVEJyyifkZ6yM8UC6wLNnOHgA9OKLgo1JTPMpaB1vfa3HXUumG3f
 8K/xVv0UcOx2JBTXHoGSuVA/BOnytUo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-rZDQ_rGDOjOIubYkLwqD4Q-1; Thu, 11 Jan 2024 19:01:48 -0500
X-MC-Unique: rZDQ_rGDOjOIubYkLwqD4Q-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-594cafcc66aso1268474eaf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 16:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705017708; x=1705622508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJdUL+Lg/0PamaK20weKlpIyGoRHMYEtQiXpU91PDpQ=;
 b=ssAqVARyQoy5H+GFQQy/KGCAyTjAcMovLsgoDMeixkUHPJYnco6ISunudld/fEGufj
 6J7Vtaa0H1Fqw0n8wYcQnjaTbvQdxEFEFmhTEx2NpIyBAt4DSJiDatJx8TZa92obA7j2
 MOjcOpU5cufGvB3s9o2rg0rgeaXyoV9mqc4ATdPmVUJyI/DbrHUXQWV74reFmUAuZOCj
 bNIUt7VXx+FI/5Eg4dhGwO6I9hCX8xOGospsZauzekOaf6M+I+7z3Zk/bZ5InpZWjY8l
 BDNzTEjyNPv4pFzb9XEcmtVtH64ts6r87yjm/VQD9TLnQR9n3LW3UEphPRPYStsgsBVn
 mGZQ==
X-Gm-Message-State: AOJu0Yw2Lx0JGLZOpXgjJ+mP+6yzbg+gFVIgvBGjGo4/0te4j+8Jh8KM
 JR8sXws2e1aLiHtKXsjJHYglqaujYXRhPYTfjlQBCq3mwjXJcYswsUQjiICvALr1ejAX/YYjcyH
 rSwjIAz+3igIHssgiyh4Nd6I=
X-Received: by 2002:a05:6358:887:b0:175:8b59:955c with SMTP id
 m7-20020a056358088700b001758b59955cmr146544rwj.2.1705017707775; 
 Thu, 11 Jan 2024 16:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0a+YmsyXJALg5OrmAwD5vbQUBMFlht8sN9cwhAi6WmI3iuVQT25J9FMOCirB18slHVqySA==
X-Received: by 2002:a05:6358:887:b0:175:8b59:955c with SMTP id
 m7-20020a056358088700b001758b59955cmr146522rwj.2.1705017707464; 
 Thu, 11 Jan 2024 16:01:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e5-20020a62ee05000000b006dac8b83f29sm1786410pfi.122.2024.01.11.16.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 16:01:45 -0800 (PST)
Date: Fri, 12 Jan 2024 08:01:36 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZaCBYLQd6CT9G9jF@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de> <ZZ-qbom2UqEX0uS7@x1n>
 <87wmsfn1xx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmsfn1xx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

On Thu, Jan 11, 2024 at 03:46:02PM -0300, Fabiano Rosas wrote:
> > (1) Does this apply to all io channel users, or only migration?
> 
> All file channel users.

I meant the whole idea of flushing on close, on whether there will be
iochannel users that will prefer not do so?  It's a matter of where to put
this best.

-- 
Peter Xu


