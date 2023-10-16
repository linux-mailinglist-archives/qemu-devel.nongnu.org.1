Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCFB7CA291
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJJk-0003OP-2S; Mon, 16 Oct 2023 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsJJU-0003G0-Ob
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsJJS-0001sC-9N
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697446257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yWwjDiAnw10Z+AukuB67MMcODBi1gu9REtgxKCH1KmU=;
 b=CunyPZHBvnjfZvlrw3c9nStR6qAQxzZbqwnwoAFGOa11SL05dOeUNjCZRuV9ZxcZMgNikh
 HxbmStnQI3PQOfH6UB9A4YoBr4YqTZTwqyGS0cCznMDJysyMn3ZpfnrkD95CoMw439Hlxd
 uywklTEhMPMlF31j8owzPTPJRDZrcoE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Ijl5I0_nOIm7IQAuJIIcFQ-1; Mon, 16 Oct 2023 04:50:45 -0400
X-MC-Unique: Ijl5I0_nOIm7IQAuJIIcFQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so420181f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446244; x=1698051044;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWwjDiAnw10Z+AukuB67MMcODBi1gu9REtgxKCH1KmU=;
 b=gxONIljgzLonOnjwsMGFy4FxKk/y9F4/xEz1+0ExPZtTThY1DRqP8NI3qdWxEBlnUJ
 S6hTqeTdwzu7gg8+yBQPBW1W4YAfDlxWE/SwDjtn4bpXa6+np41dDe7zAtJlf85nfdLw
 64KzUMaP86mOr4WH68og28j/R8Mq4NBXGMMxBEwRb5ePBViWqilm+4tT2WQDW4gqxn4i
 o6xhXsomahu3x1pcb0I9NIGOlsciAba+jGaMq1/y6wJh1uLS40P9uFj+zAx2tN8B36zQ
 GvN+UYKIW8WnJ32n5+jNxAlKIU2HdHhajABfI52nwV+Ofs5NwnTfHuxXybLxduUftesU
 0TOQ==
X-Gm-Message-State: AOJu0Yy3+BYLEDvFrKBo5Y/7JYiv5l1NmxaxHOuDqpLWwwr2vKdQZF0L
 R2G/XIZsNioihW0HTr6dP9T8O6JgkKolDtAK/NtDHVLrLyrpulxSk2/8t0BksB1X/a8oqJ4FD8D
 QrQasT/vFzuYHfV4=
X-Received: by 2002:adf:ee88:0:b0:32d:b081:ff31 with SMTP id
 b8-20020adfee88000000b0032db081ff31mr2470765wro.66.1697446244448; 
 Mon, 16 Oct 2023 01:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVHr1Ru39UNbG2uR53Io4Bv94QVU/YD3XRiK1oEX6DNIVqUJVdQD8OtrjiDi1RzoFLdk5sYw==
X-Received: by 2002:adf:ee88:0:b0:32d:b081:ff31 with SMTP id
 b8-20020adfee88000000b0032db081ff31mr2470751wro.66.1697446244129; 
 Mon, 16 Oct 2023 01:50:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b3-20020adff243000000b0031431fb40fasm26759110wrp.89.2023.10.16.01.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 01:50:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 3/3] migration/multifd: Clarify Error usage in
 multifd_channel_connect
In-Reply-To: <20231012134343.23757-4-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 10:43:43 -0300")
References: <20231012134343.23757-1-farosas@suse.de>
 <20231012134343.23757-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 10:50:42 +0200
Message-ID: <874jir3q8t.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> The function is currently called from two sites, one always gives it a
> NULL Error and the other always gives it a non-NULL Error.
>
> In the non-NULL case, all it does it trace the error and return. One
> of the callers already have tracing, add a tracepoint to the other and
> stop passing the error into the function.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


