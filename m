Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F87B2F24
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:26:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9kQ-0000z9-9q; Fri, 29 Sep 2023 05:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qm9kK-0000yp-FA; Fri, 29 Sep 2023 05:25:17 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qm9kE-0005Y0-5p; Fri, 29 Sep 2023 05:25:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 9ACA261079;
 Fri, 29 Sep 2023 12:25:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:8579:d8ea:63ba:e50] (unknown
 [2a02:6b8:0:419:8579:d8ea:63ba:e50])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xOOG360Mpa60-rjSQpxNI; Fri, 29 Sep 2023 12:25:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695979500;
 bh=kmvwIZRO7q8j3W/xs1lcTQC0p+myvPS0vV2EFAmfrwA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rgWr8sfL6HyRn4l/9UAd6HWzFlnG8Kko9a4w4y9Gu0HK/sm+WDvEd4VoFYPgUgWbc
 NBlwlg9B9Dpm9jF1Kd5Y//uGutBxR5tKWX3UZrMWJxPo197CiNY5YhpeaHQcfkJv7t
 /MAlWv0Uqyzfrsu+CILnh14DBT9Ty3sXh4JQgcOQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3d88cf50-3414-87e2-c17e-6c6aa5cc74f6@yandex-team.ru>
Date: Fri, 29 Sep 2023 12:24:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 07/12] nbd/client: Initial support for extended headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-21-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230925192229.3186470-21-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.09.23 22:22, Eric Blake wrote:
>   nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t cookie) "Got simple reply: { .error = %" PRId32 " (%s), cookie = %" PRIu64" }"
> -nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t cookie, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), cookie = %" PRIu64 ", length = %" PRIu32 " }"
> +nbd_receive_reply_chunk_header(uint16_t flags, uint16_t type, const char *name, uint64_t cookie, uint32_t length) "Got reply chunk header: { flags = 0x%" PRIx16 ", type = %d (%s), cookie = %" PRIu64 ", length = %" PRIu32 " }"

preexisting, but better would be s/%d/%" PRIu16 "/

> +nbd_receive_wrong_header(uint32_t magic, const char *mode) "Server sent unexpected magic 0x%" PRIx32 " for negotiated mode %s"


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


