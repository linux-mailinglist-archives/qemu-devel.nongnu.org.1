Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CEE7D0B15
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlQg-0005qn-FX; Fri, 20 Oct 2023 05:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtlQV-0005hd-RT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:04:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtlQT-0004YP-OP
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:04:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40850b244beso3647695e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697792652; x=1698397452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LV+TTpoR2W5z/eLtMV7w5gTIRRPNVNLtDhd8ldgJh+U=;
 b=DvYqrQWoay0sxsUMokMYOa0HKEqkz4/YEPbkJSUsVx8NLjZHpaapRlpEHhmloiXpYq
 hYBIBcyDUZSt6JD8CdC0p07JEYm4DkZdMfUedsyvqGLHYc1rAAFQOeXPq4r5Q7PVWNk4
 +N3yYQrN4hW410dJm+uEmOBBqJZp1ieKQVQ2GpcBbTlZ3n6QGWOrlLWM8w8qyOlzz4iC
 eUUmQLcgeG2Z8Nb2pz+HgktnDBGVPAXtiU+cbutL5ToOGly+/9wd97/3W8cW7pi8uYiW
 IHFbSGSA0RwfIxRZjsBd5P4bQQPRxYz4hqeunDZXPxPZLK2IDN8MIaMtthXyQVu9IUeL
 kAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697792652; x=1698397452;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LV+TTpoR2W5z/eLtMV7w5gTIRRPNVNLtDhd8ldgJh+U=;
 b=P657oE+JlTP48vemFJ+rlaHC3RtBBnD0+5OUuhEtWK1SfRGuT8HmuAIac9Z8LpgVdS
 WMYCJJrGigmOkrQn4nDNOF5koZlqPsLIJz+GhJKsHORx49UsY4AJnvVgVLeNrJONBiTW
 La/VDxFVe0denuLW7UgvsD7ZQi5Cm7BjIBRTOXG5v4Chi1ulQQrS4NHzjr+Hq9EPB8Dx
 Te8mp9V1nGt7DLunAVa6Nup9+HBsSBw4mgErhQyHdD9PxvwztkuhZmy25/ruLzECrx0r
 xDz1xTr2ufrlhfQZDFUuddEA0kNFVegP6DvecGG+Yrxi25kSzEQnwYp6Ndrk19lwbBgJ
 CbgA==
X-Gm-Message-State: AOJu0YypBttY0BjlzuYSxQfOSfrzn6c5PJZZkV+Mfy4VqZ5F6bwGO6xy
 HUH9YNQJ4acAvcgAXpb5FPR7wg==
X-Google-Smtp-Source: AGHT+IHYmK5Gs42IL/m+dDi4TyVIb7k5zNXb/HiU9Sw+1v0uiB7U/snGKbQaC4AOS21a4VDtSFlpjw==
X-Received: by 2002:a05:600c:1546:b0:405:770b:e90a with SMTP id
 f6-20020a05600c154600b00405770be90amr911988wmg.34.1697792651790; 
 Fri, 20 Oct 2023 02:04:11 -0700 (PDT)
Received: from meli.delivery (adsl-21.109.242.226.tellas.gr. [109.242.226.21])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a05600c15d200b004063d8b43e7sm6416897wmf.48.2023.10.20.02.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:04:11 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:03:50 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gonglei (Arei) <arei.gonglei@huawei.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v5 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
User-Agent: meli 0.8.2
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-6-alex.bennee@linaro.org>
 <20231020031407.xd4ykc4msfdmoav5@vireshk-i7> <878r7x90a0.fsf@linaro.org>
 <20231020050210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231020050210-mutt-send-email-mst@kernel.org>
Message-ID: <2tl6x.csk4mc5p2sx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 20 Oct 2023 12:02, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Fri, Oct 20, 2023 at 09:16:03AM +0100, Alex Bennée wrote:
>> 
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> 
>> > On 19-10-23, 10:56, Alex Bennée wrote:
>> >> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> >> 
>> >> Tested with rust-vmm vhost-user-sound daemon:
>> >> 
>> >>     RUST_LOG=trace cargo run --bin vhost-user-sound -- --socket /tmp/snd.sock --backend null
>> >> 
>> >> Invocation:
>> >> 
>> >>     qemu-system-x86_64  \
>> >>             -qmp unix:./qmp-sock,server,wait=off  \
>> >>             -m 4096 \
>> >>             -numa node,memdev=mem \
>> >>             -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
>> >>             -D qemu.log \
>> >>             -d guest_errors,trace:\*snd\*,trace:\*sound\*,trace:\*vhost\* \
>> >>             -chardev socket,id=vsnd,path=/tmp/snd.sock \
>> >>             -device vhost-user-snd-pci,chardev=vsnd,id=snd \
>> >>             /path/to/disk
>> >> 
>> >> [AJB: imported from https://github.com/epilys/qemu-virtio-snd/commit/54ae1cdd15fef2d88e9e387a175f099a38c636f4.patch]
>> >> 
>> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> >
>> > Missing SOB from Manos ?
>> 
>> oops, guess I need a respin then ;-)
>
>Just ask Manos to send his S.O.B in a reply.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

