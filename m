Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02A7DD594
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:54:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsw1-0007SC-Hl; Tue, 31 Oct 2023 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsvz-0007S2-TS
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsvy-0002SC-6v
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698774825;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cFfMoYK2y+vhqNcmhlIo+Hzsw922AAwrVDDImGGjBmI=;
 b=EIbpYGxbDdFcoXCzCQSf7f769jQ/GNTGUP4UseXsYbhf2DYAF9JI3JzFYLHRxWD9lGFyNM
 q5knAz5VqYPeiV6DHi+Xp5m5Tb04GueA1tMRYfIFyPKBkJBDeKbZIZusa4YCusZrf0lEU5
 RP4zF54joqaX9nXNG6jDELlh0BvQ9fE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-dgDxItAqOICbcOgWJVBbHg-1; Tue, 31 Oct 2023 13:53:33 -0400
X-MC-Unique: dgDxItAqOICbcOgWJVBbHg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c6b30acbaeso32775951fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774811; x=1699379611;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFfMoYK2y+vhqNcmhlIo+Hzsw922AAwrVDDImGGjBmI=;
 b=ND5lARFe0pWuLlroGG1rSvcTJxlxmZuQKrskz4gDhXH8QI/ID42z3DGjy2dSN9PW60
 iSps+yA4P0WZpmMKrHF8Qn3jdwZB/q9cu7yrUghCpPEBumAvkHY90YR0Y1+djF/f1Voc
 KGYVY+im0F25nFi4KyM2eVheGAyylZvSxlNfceYjEOLIcDuDfQaMoaqVVUc9kpOC+bvV
 Df7pc3BMlxG+DdA7RJsYXzhY4uPe9a2BCS6/wSkAGPqin+Bpm9u6+Rq/yjgWM3RxVWEr
 fBmdSsDZe0Qc0Y38Cz8lX79Xm11/sQ3Ca9wzLLKGxSS8kTX5Jlkb0asCAqraGVphASkY
 /f9Q==
X-Gm-Message-State: AOJu0Yw6DmQCArt5TogHVrY1EjBxnfuOE0l7n5g8yzkEMfCThbImte9S
 A7Q4TSZFXO65RnKfypPjtuLJqQxLW/YHR/djE9DfhYJU20oco0HhnAsyRW5FAjFT01E+26ThLwd
 52CvcZa6y67MVcUU=
X-Received: by 2002:a05:651c:2109:b0:2c2:c1f6:3097 with SMTP id
 a9-20020a05651c210900b002c2c1f63097mr13469022ljq.22.1698774811625; 
 Tue, 31 Oct 2023 10:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9aMACKeqZj1TQjsGoqVtTDng9BazJJzmAVQ4d6t8kFenggQ5AiiIU7dCURoeN4spFnrhWiw==
X-Received: by 2002:a05:651c:2109:b0:2c2:c1f6:3097 with SMTP id
 a9-20020a05651c210900b002c2c1f63097mr13469001ljq.22.1698774811287; 
 Tue, 31 Oct 2023 10:53:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c199000b003fc0505be19sm2368342wmq.37.2023.10.31.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:53:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 12/14] migration: Implement MigrateChannelList to
 qmp migration flow.
In-Reply-To: <20231023182053.8711-13-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:51 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-13-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:53:29 +0100
Message-ID: <87il6m4r1i.fsf@secure.mitica>
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
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for qmp migration.
>
> For current series, limit the size of MigrateChannelList
> to single element (single interface) as runtime check.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


