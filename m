Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1A7C552A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZAV-0005Ns-US; Wed, 11 Oct 2023 09:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZAR-0005NP-Es
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZAQ-00040Q-1z
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697030545;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z1Sd6uvIfUPUJ4D5Ncf0PRuVTIZ+sNAobxp6KvLRpmI=;
 b=Vgv62v6SkAdOF58avyW8duYvLrvrcc5ktD6icjVkPxbLzJe54IE8ZjcxcmhwNsl7ey4nSx
 oa9rwile96dLBXV4KNQiUFvamnZPSYDOTedg7j1IOYBwm4SVtr5tH3AmdOurn1sUAKUJBs
 qJ0a9lQWJy5h7e/RZqEmiyQ9NqRYeXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-nXAiPWggMSmFkaa2ENRSmQ-1; Wed, 11 Oct 2023 09:22:23 -0400
X-MC-Unique: nXAiPWggMSmFkaa2ENRSmQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d879cac50so330779f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030542; x=1697635342;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1Sd6uvIfUPUJ4D5Ncf0PRuVTIZ+sNAobxp6KvLRpmI=;
 b=Md3e5twTCQXxIXrEczp7Wj94Kdnc20n+RUMfGZjhqYS2j0CC/eapkzQMcsiBYGs0mF
 KaSwgfhnO+BGQHq6Grk5Qq3NrYHtPkovRfzjs8LVtVk1qp//9UrZGFeUQkeCWNlntoxM
 Xr0h+w0L5kKynYfr1ZW7DI3tHO0HqsLJBEaW5gusyDDGW/xobfOnZyaXSAC22DQN/U4d
 9/oIm0UJ5pN/hzqh4spp1xtXHYOQRREnsStQdqf+s1YdtE3ymU4UDSHbnJAhEIp0GIf+
 zd1WSbF2v5vHblv0QzU7b7VpSvDixPO71SDoCsePb1BY+t4BHrggeLBj4L4RTIqNHb/1
 RLrA==
X-Gm-Message-State: AOJu0YzMpa6uuvw4Shzda+c/bCdJTBTybh5HVVfbZ23MsRN6PytDels8
 Pln5Y4DfodY7+LlfW/GrPW0UMYPeDHUrGTxBqtruLUuGolfjJTssbsGJwGpQF9kGuLa16w1p8xg
 iEnbIO/P4Sdd+Ytw=
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id
 c11-20020adffb0b000000b0031fc1b5d4c1mr17298484wrr.35.1697030542573; 
 Wed, 11 Oct 2023 06:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHATtV071LE7JMB0ogc0lAibsFEacBEIN//Z8PWZatgbONkD3PmgArX0aQzaXtJTTr4CNY2tw==
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id
 c11-20020adffb0b000000b0031fc1b5d4c1mr17298470wrr.35.1697030542283; 
 Wed, 11 Oct 2023 06:22:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q14-20020adfcb8e000000b003296b488961sm14851833wrh.31.2023.10.11.06.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:22:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: Add capability parsing to
 analyze-migration.py
In-Reply-To: <20231009184326.15777-4-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 9 Oct 2023 15:43:23 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:22:20 +0200
Message-ID: <87zg0p9tv7.fsf@secure.mitica>
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
> The script is broken when the configuration/capabilities section is
> present. Add support for parsing the capabilities so we can fix it in
> the next patch.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


