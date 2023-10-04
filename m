Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E97B8508
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4ga-0008Hd-Ce; Wed, 04 Oct 2023 12:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4gW-0008HI-Ew
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4gV-0006Jt-2S
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ocpgGqorRDcIxtX2ofpUOExuH0dkr7CbdkG8pHph118=;
 b=U897NeuLyPC85dGyp8vpM13DuIn8cP5c3H3DKLoJh4b2WGl9BUkRPQdsDHUgJT2MkXBuoV
 yatvJ8nIcIGtFuP3HYTukxM8vvCcDZ+7EEo0r2UpI5whnKCpSU0KhhEW3GqKu243ZXC94U
 PICG8/az2DMM9OquZuxEsrkGKr27gTo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-w5ak6pb0P9qwgXI5QO6lvA-1; Wed, 04 Oct 2023 12:25:12 -0400
X-MC-Unique: w5ak6pb0P9qwgXI5QO6lvA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-323334992fbso31585f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436711; x=1697041511;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocpgGqorRDcIxtX2ofpUOExuH0dkr7CbdkG8pHph118=;
 b=wA0MyUwMf2P7nfe0JApZ1fzGvv3ffAdQyKJurVwRdrvikfSIfZrgs7QQsAPNelSH8g
 rXXp07l+q/RtjPhsY9mbQD4juqgboogODp7G66a9hv+e/rYN3hWzWoKcnrXEufsYjt+d
 3ksPyvOQiiReuOTi4feuK98rQuiRGY2OfllyQ69iun0gOgRglCgB5fXqBWt/vKdMfNTC
 8Juut1qr7eK2wF3rOz7BnES5BizhFG83UDdw1fZodMpi920PgoAykkiV3QrJNb2iTFAv
 rV5CnDQcdEShC0W0cbLe7JTOnWwHJjHXXh0737vFfnd9idv9lffaiPiBRpza8bq0rxwL
 HXSA==
X-Gm-Message-State: AOJu0Yy+zoyB0LQtdr+91KRtRdaDuBqquAjW7Hd/GaIHVh7JO37VZp/W
 YHqyn/yuXDthKBcqUKtylGNAiP5jM6h8xHFEaDHzfb5YTlgkPZRvvHMBY83Vy5GpdEpdtIaa0AF
 LhKD3miGiir5OExo=
X-Received: by 2002:adf:d4d1:0:b0:324:7a6b:d503 with SMTP id
 w17-20020adfd4d1000000b003247a6bd503mr2695898wrk.11.1696436711173; 
 Wed, 04 Oct 2023 09:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvOeNNqagL4eGy31ImJnzkLj5w4sgYimWcuagjAHsEQ3HpH9Uhk4h+BYvXcjdw7MsT7XgkqA==
X-Received: by 2002:adf:d4d1:0:b0:324:7a6b:d503 with SMTP id
 w17-20020adfd4d1000000b003247a6bd503mr2695882wrk.11.1696436710872; 
 Wed, 04 Oct 2023 09:25:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r2-20020a5d4982000000b00323330edbc7sm4376734wrq.20.2023.10.04.09.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:25:10 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 26/53] migration/rdma: Dumb down remaining int error
 values to -1
In-Reply-To: <20230928132019.2544702-27-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:52 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-27-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:25:09 +0200
Message-ID: <871qeawe1m.fsf@secure.mitica>
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
> This is just to make the error value more obvious.  Callers don't
> mind.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


