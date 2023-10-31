Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDBC7DD08E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:32:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqiw-00058y-5F; Tue, 31 Oct 2023 11:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqis-000532-UG
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqir-0002SY-FI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698766324;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PNcAVNHUh/8F7OFH2Pv40WG35Z1rrB4/q6PX7ryVpxU=;
 b=ejhMpLGIWJ/pMLRRy7nAGJw699YsJsOiZzOJ2lubqKnbOy8NlaQ0vlDOswz9JYws4CetPH
 YS2q1M5+oaMaWg+/EjB+qMYEQFBOEDvXG3lx58FzDqufDWwPP2lGxSzomXAyTibcCCIffB
 rLyts4TnJBLF1+gUXzVRb9Je08Pfjf4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-z63EYQ3kOtWCiVfzcizL_A-1; Tue, 31 Oct 2023 11:32:02 -0400
X-MC-Unique: z63EYQ3kOtWCiVfzcizL_A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507cb169766so6326773e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766321; x=1699371121;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNcAVNHUh/8F7OFH2Pv40WG35Z1rrB4/q6PX7ryVpxU=;
 b=bQe44Gb4jIYOlXcn3MEPEGfrneMU0l4+ebiFhu2jcdUiz+ve5KzGchSBf86BgBCP+B
 qFOSzrot8xzYVWxWOKHRqM0NCXQ9bumpRU1rpnjRw610rwOYTsH+6ySfzNEH9fXPkOjx
 Gt4N8XymKd+ZnHGURyuVbyxqudo8wAw2SyJShnnD/7b7gkWaOYXs8lS/4AacdKRg8f+v
 YX0uyP2iUJFNIq0Tp86bSRlhBIBVZDFZopSErrXxagHDMo0ydv7zpLisTi9A0SWVlMOQ
 gHk7nH3xX4n12sXRpii5qd5gUticp3KJ4m+i+VRnrefxTyHIJqCGZIAyu3QiEotGSONx
 0ROw==
X-Gm-Message-State: AOJu0YxcLduWOW2CO8oEWtLPYowmaPRdIkOdsdkjKBwfF+e8HQ01EhrP
 mZyATve2X3LQhZ+sDT1wMR86r1yMxq5ZB253iepBuJ8Tdv8rW5SgH0VNZH9ALRqHv1Syn0dOtht
 1P9FENsB7Y4ZvCw8=
X-Received: by 2002:a05:6512:3b29:b0:503:3707:66ed with SMTP id
 f41-20020a0565123b2900b00503370766edmr13051326lfv.34.1698766321088; 
 Tue, 31 Oct 2023 08:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbBvB2PIQyepwSw85qOTsQNEvGKpIOOWIQDmLxIGOnFqadc1QMPsD9n9ryNTbUD1o7lQQm7g==
X-Received: by 2002:a05:6512:3b29:b0:503:3707:66ed with SMTP id
 f41-20020a0565123b2900b00503370766edmr13051290lfv.34.1698766320756; 
 Tue, 31 Oct 2023 08:32:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s2-20020adfecc2000000b0032f9b59c1b5sm322973wro.96.2023.10.31.08.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:32:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 07/14] migration: convert exec backend to accept
 MigrateAddress.
In-Reply-To: <20231023182053.8711-8-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:46 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-8-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 16:31:59 +0100
Message-ID: <87fs1q6c5s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
> new wire protocol of MigrateAddress struct.
>
> It is achived by parsing 'uri' string and storing migration parameters
> required for exec connection into strList struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


