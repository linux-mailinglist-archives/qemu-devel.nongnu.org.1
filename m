Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D87B84F3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4fD-000655-Om; Wed, 04 Oct 2023 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4fA-000635-4A
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4f8-0005vG-FZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XEFrc28FGMOPgViS8SDi6vrZa/x32Sert+ujjCeK9as=;
 b=GSlrwtEHq+kuKaFvIEysEAs56aHriO1mXRe24mZsxi3UsNXBwNygJw+jvRpbwe0Nsbmqg+
 T8AaIS8cnYvBUlTegKAiey86fWNWTjDxjDY7qFSFG03L+bR7GwHFWo68r8cFojz6N3xv+n
 fPfjqnOW0DmJGh+aMTv3HXLX9U1AvNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-lAHs8_XoM-S_qgF587iOpg-1; Wed, 04 Oct 2023 12:23:46 -0400
X-MC-Unique: lAHs8_XoM-S_qgF587iOpg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4054016ff33so198715e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436624; x=1697041424;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEFrc28FGMOPgViS8SDi6vrZa/x32Sert+ujjCeK9as=;
 b=MOJEhLGscuNc2MUgzEjOhAHagfIJWzZTIvHHwiIEQ4ifz777cTbS89JFjuBBcT3QIs
 A5+4z5eyqrrGv5gWG9ysFZuSyHZJPkei2/KTF7MxhG2RPd7x0l/7c5u8Sg68EmC9oKfl
 5ULTs1DObJuL01NaTAP8peLCk5PyJlcRjdSyWXFX4XINzdOgtJL5Q5V9HV+T/Aj7iVtU
 FiTC93fabWq9rwaZvmSJMl0jtXVc6DoAsAK5BEZIPNoE+SmKKTNfjTyfBFv/KByJg6r+
 owaTw+bopw9t5FcyIqKtERa0/K2HLfETWbotBa4G+i0VUMZidQsFGXfmo5lOV2Mlsxam
 25Ig==
X-Gm-Message-State: AOJu0YzBLRxeN6PfyUjP3ehZblQmY0VTGUjrRYgFfkk9t/hl7zB5gIkX
 xOOrs6F8v1vBqvKX93cPt308Ojao/siapzXzXLY6Vt+32cjZnoB9ZoK1ACQDuX0+NwDjUAFofGL
 FL1d1lZBxjYhakYh2KIbfN4P36g==
X-Received: by 2002:a05:600c:2108:b0:402:ea8c:ea57 with SMTP id
 u8-20020a05600c210800b00402ea8cea57mr129706wml.7.1696436624475; 
 Wed, 04 Oct 2023 09:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEApOSfMVn+yxTBnqlD0KFxmmhaKfkc+7WcT9rxqvoGxgbz+ykMAH+ccbj5jS8miwjWe4mEQA==
X-Received: by 2002:a05:600c:2108:b0:402:ea8c:ea57 with SMTP id
 u8-20020a05600c210800b00402ea8cea57mr129693wml.7.1696436624145; 
 Wed, 04 Oct 2023 09:23:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 a4-20020a05600c224400b003fe2b081661sm1903020wmm.30.2023.10.04.09.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:23:43 -0700 (PDT)
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
Date: Wed, 04 Oct 2023 18:23:42 +0200
Message-ID: <875y3mwe41.fsf@secure.mitica>
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


