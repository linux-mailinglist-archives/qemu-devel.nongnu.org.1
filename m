Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AAC764090
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 22:35:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOl50-0004F7-CL; Wed, 26 Jul 2023 16:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOl4y-0004Es-2m
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOl4w-0005ue-Hf
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 16:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690403148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=AUYNYOAKsStHoc6JzLZxa2TJmtUgVBth5GkuvavaHJo=;
 b=eyW2XPJMAdwz0QiSqoarr1CJrp2Hn6WqUSc2SX/yUrlPAIVwajaVEGKka0iIJmp/I90m3W
 ILcKJlGObcY0D8L/o3M1pAbOSQGC8KZ24ZiFuJ80rxz7BWY1QKgwUqt3icj2t45UsoCuS5
 ETtlmbkVsziDonUaCu3fDgcqf9MIm2k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-dQI--9PCNDmzXzR2mX0NCA-1; Wed, 26 Jul 2023 16:25:46 -0400
X-MC-Unique: dQI--9PCNDmzXzR2mX0NCA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-267f18688efso189747a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 13:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690403145; x=1691007945;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AUYNYOAKsStHoc6JzLZxa2TJmtUgVBth5GkuvavaHJo=;
 b=DBsjrkOguigE8Yc4R1rBIDyhLuGEPja6bN/+X0uVNy103szxxqYaAfIBAkSA0WNTgP
 E5xW7UqMFyFW36G2gWcGH1IyLkfIYTwrYCQgqs29kh10TY6qiVYKsj/vl7YSsMxpHnGE
 Sv0MqG9X9z9q2XYqqBlR0hiNd20Pdxm+M0XXxX1gqPMQCiSY33HniKdfYBldfJbM8/Bj
 RkjJMBlCUfVrtfOSlDnv3Fn3oKafqKZAar7+L7M3EREZLvdFSj7wX4Y5pEQj9MDsg8eE
 SueosFdY/atVWM8ykm4IUleWbXj6cFhfJiuWvWVqLDz4XpAIy+X14oGWtNoTwHiD9yW/
 2vvw==
X-Gm-Message-State: ABy/qLZrH2ozpldvoYyYOWpE2BNYzRHfa4WC8FvuBaqwKY8CBYmcRmdY
 4wI2ZpXzAq1uxIRZGU6JL47MH64koN+yqMbu+N5K2DeA+gmX7EaLWqvTwAHN71gI4OK7QNuuUFu
 GhFR/EeZ6FvK1FfPLX7P2lrMHhgW79rw=
X-Received: by 2002:a17:90a:2acd:b0:268:2f2:cc89 with SMTP id
 i13-20020a17090a2acd00b0026802f2cc89mr3022103pjg.4.1690403145709; 
 Wed, 26 Jul 2023 13:25:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxC5E7W2Fg2BymbDrnm01QZRAMrWVdXxK9Vo5rGeBrc/W4irXlUDS03UvFlY1kBPVz75k9ZbzYh7PpQw7xc9w=
X-Received: by 2002:a17:90a:2acd:b0:268:2f2:cc89 with SMTP id
 i13-20020a17090a2acd00b0026802f2cc89mr3022087pjg.4.1690403145222; Wed, 26 Jul
 2023 13:25:45 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Jul 2023 16:25:34 -0400
Message-ID: <CAFn=p-aKWG7r2zRdQ-O6kod_jVOTMELGi_ObbKBAM=9ZgXt7Ww@mail.gmail.com>
Subject: Implementing "tee" in python asyncio
To: Daniel Berrange <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi folks,

I'm currently wondering how to take a StreamReader as found on
https://docs.python.org/3/library/asyncio-subprocess.html#asyncio.subprocess.Process
and to consume the data while optionally re-streaming it to a
secondary consumer.

What I'd like to do is create a StreamWatcher class that consumes
console data while optionally logging to python logging and/or a file;
but re-buffers the data into an async stream where an additional
consumer is free to use the "standard asyncio API" to consume console
data at their leisure in a way that's unsurprising.

What I'd like this *for* is to be able to do aggressive logging of
stdout/stderr and console data without denying tests the ability to
consume the data as they see fit for their testing purposes. I want to
have my cake and eat it too, and we don't do a good job of managing
this consistently across the board.

I am wondering if there's any way around creating a literal socketpair
and suffering the creation of a full four StreamReader/StreamWriter
instances (one pair per socket...) and then just hanging on to the
"unused" reader/writer per each. It seems kind of foolishly excessive.
It also seems like it might be a pain in the butt if I want
cross-platform compatibility with windows for the machine appliance.

Anyone got any bright ideas?

--js


