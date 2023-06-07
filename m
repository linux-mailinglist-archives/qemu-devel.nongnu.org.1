Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE9725448
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 08:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6mhA-0005PW-Mf; Wed, 07 Jun 2023 02:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6mh7-0005On-Sd
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 02:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6mh3-0005Hw-Cz
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 02:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686119450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vZKGwfxDAfyv8l9r37a8ZG6wFwkZWbbKNZWpsqT8gIY=;
 b=TmVAf6ST6c4UQeq2F3A/85sMfjDQZnfnucbuPkfmPjTNRMgBCTnCAilgIlfP5HDCqM39OS
 Apus70PIjvAFxzAaajyIwhzIJEBtUzNdLSOS/WXr1M43MrrTkeSPNkSw3zwcmCoIZBSqo6
 OMKmVQxVpXkN+N3lKahNF4TzRgAhgKA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533--_D4cy2hPc6heYH2AdXv6w-1; Wed, 07 Jun 2023 02:30:49 -0400
X-MC-Unique: -_D4cy2hPc6heYH2AdXv6w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7ecfccf2eso4234605e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 23:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686119448; x=1688711448;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZKGwfxDAfyv8l9r37a8ZG6wFwkZWbbKNZWpsqT8gIY=;
 b=YVQ9aYtPW2ZJiCWonY0KAilWLlzWdrE5odQHJltZ/9N4c06KZa5Adgj7cIH31rHOD+
 tKt+4HW9XQUY7O8fIJyEonOq9rWUnrBGC79NxvNumsMkSIXu97CSH2FSH6bYXs6GY19c
 n2c696c8WvMvKUFk0SudENhwT0FqA5rWUqHZjnj6GLqDUzDabI5bYePg3AGkGRfDNwbx
 mjlMCX/p7oS5zwo/Lwa2r3t9VzlH0r+q31+miQ3WFqNCaGavGNtsfp9WbushlrLqwZ7J
 5pRYtUs7qIVhU8hgTcm/bZ40dMxPkOtbpdcwGjOaLWEV4plS2o36XMNR2OyogJJ2GE3d
 YY8A==
X-Gm-Message-State: AC+VfDyfmRnxZ8sSPK77XLxZhYcZlMOi63+ZFrIETKCOCxlfVSf6Jsgi
 BEhmWNCg1594+sdmR2VIPu7kzAl5L/aC0jhGywB/7AT5pZocmxS9UwtY2V28YDOh3ZXMhj+0Hdy
 6vlrYHaqc4nkawBc=
X-Received: by 2002:a05:600c:ace:b0:3f7:e6d8:457b with SMTP id
 c14-20020a05600c0ace00b003f7e6d8457bmr3633500wmr.19.1686119448244; 
 Tue, 06 Jun 2023 23:30:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6A0Apz6zo1bpWgGALml8ksFmJMU1higwMdg7X09ndcTFQG8uYrM7VHVhOGAgTI/tJl5WacgA==
X-Received: by 2002:a05:600c:ace:b0:3f7:e6d8:457b with SMTP id
 c14-20020a05600c0ace00b003f7e6d8457bmr3633485wmr.19.1686119447898; 
 Tue, 06 Jun 2023 23:30:47 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b003f7e66a51dfsm969336wmc.28.2023.06.06.23.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 23:30:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Jiang
 Jiacheng <jiangjiacheng@huawei.com>,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration/multifd: Rename threadinfo.c functions
In-Reply-To: <20230606144551.24367-2-farosas@suse.de> (Fabiano Rosas's message
 of "Tue, 6 Jun 2023 11:45:49 -0300")
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 07 Jun 2023 08:30:46 +0200
Message-ID: <873533pyw9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> The code in threadinfo.c is only used for the QMP command
> query-migrationthreads. Make it explicit that this is something
> related to QMP.
>
> The current names are also too generic for a piece of code that
> doesn't affect the migration directly in any way.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Don't like the caml case.  And don't really care with/without the qmp_
preffix.  You got it eitherwise.


