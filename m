Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA97B85D6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo57x-0004ie-F3; Wed, 04 Oct 2023 12:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo57q-0004i2-BK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo57n-0008OO-IJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438396;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hMwIbaiRFZpu+TESWOyUH6veWZeO21lNWq7zH12V16w=;
 b=SH3dWyt4DPAey846AuqkISKIvFsuXMCT7HagfqDg3iME3zxJuqjlmGNJsi4n9sdXCotw8x
 ExoA00JH/mLdJSB3FN8KlQ1F3wlgeQuKZrJ3YsfiXbKBgVsm35/3GerV7wBCGkxXAWWJ8v
 dpzptkY71ybRX7TTNWbErsWkJDT4mmw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Rg8HRQ4ONO-8OZSCDYHmwg-1; Wed, 04 Oct 2023 12:53:00 -0400
X-MC-Unique: Rg8HRQ4ONO-8OZSCDYHmwg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40554735995so43665e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438379; x=1697043179;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMwIbaiRFZpu+TESWOyUH6veWZeO21lNWq7zH12V16w=;
 b=H4rfh4Xm3nquAC0swD3Uaglor+5SN9IE9bxLYxyk165NR8OoxUCTZ6rTRAl24telZa
 /dFA3cbZUkK3Cpppi38ElWPkw2EiRFwFEa/maqKfOWI4NF3t06k8TUd6ewcov2JKqCdj
 nNP2xNZNwW7EwVNdFG1UoCwvhc5dj+f6HqrqVZSWxjZMvOtfZCtf738mY7/rYBsOxII0
 AtejKYI1++QeurcZGpRkLPqjyNlyGve/nCeQOEs+nyj977OSqRuKyjxTR9ziCRXtg1Sf
 z+W5jW5Uskfk8UX2Hx7QX44sMaPytakFNIuq0H0yUoLKZUogUWhq6CewBVSQ43/VGJ49
 FXaw==
X-Gm-Message-State: AOJu0YzaGBCB3bvZKc9p93Cr5oV7DphGIo2TB9cYFMNiBAEfUgvP3t3h
 mL/+iljC3Pol1dQxmhoJlDRnzYmj1Pwp/cbFuoHYmO3COhqvreJV5A4gKYhb13Ennc90h4oFFQq
 R5f3oSx2Mg/rHVGM=
X-Received: by 2002:a05:600c:2242:b0:406:517f:ac85 with SMTP id
 a2-20020a05600c224200b00406517fac85mr2705885wmm.18.1696438379662; 
 Wed, 04 Oct 2023 09:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaqCaDbMTVk+mdN09t2Dg9MwPyi3M4qYFupw+tSi578tNthujYxm29i/wAu00sx3LQevNFnA==
X-Received: by 2002:a05:600c:2242:b0:406:517f:ac85 with SMTP id
 a2-20020a05600c224200b00406517fac85mr2705876wmm.18.1696438379392; 
 Wed, 04 Oct 2023 09:52:59 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y18-20020a5d6152000000b003233a31a467sm4419175wrt.34.2023.10.04.09.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:52:58 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 34/53] migration/rdma: Drop "@errp is clear" guards
 around error_setg()
In-Reply-To: <20230928132019.2544702-35-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:00 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-35-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:52:58 +0200
Message-ID: <87v8bmtjmd.fsf@secure.mitica>
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
> These guards are all redundant now.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


