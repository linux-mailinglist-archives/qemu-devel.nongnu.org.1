Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEB760C5B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 09:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOCme-0002sI-DU; Tue, 25 Jul 2023 03:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qOCmO-0002s0-FH
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:48:25 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qOCmL-0002fO-Sl
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:48:23 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b96789d574so71218031fa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690271299; x=1690876099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E3rgMwuG7hjhsKDt4LoTwaRxESOsfXW0SJ2BWKdkus=;
 b=gMORCkP/OP8QFGaf6FF+7MjasfNqpDcUIXR4waVIK07YMe7WyRRSXiWhLYs8C7Ic4S
 4bimsGnkl8dF6HBA48KHnah9TnfmhdU76+cQUrXlC0I+XzUoKGHTzFcbcuJxw36WUH73
 9q62wxd7LIgokqJUgbMVA0xeBplNtb1dPx8WSiIZaJWByTZ+tODWwe2oSSUxFxXydKUU
 8EoYa57QdBIosn09B9RrsLABXXv+TQ9VY0pG2UYMJah7gQ6x82E98DfF4zZuw3LkJkPF
 xi1IYzcdXgtHL6SbeGZJpKXYwq0imj9cwOVcQLfcRsUUQSzhwXrkNeYwF8WSLT71kOyk
 NQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690271299; x=1690876099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E3rgMwuG7hjhsKDt4LoTwaRxESOsfXW0SJ2BWKdkus=;
 b=FFzRRyF1NCUicUX6X1Qwuav26h2YCjEG06Py0u+U9qLQxANuN3JZXZmhZDdSz3viFF
 b/0W1He59BfRr7rrOp8GsysxOiK1Fqx7J23SyM/2dnwmJYBXhs3Z6czp8USQ8ZXjJDnB
 bHrelWt9J7OvaxMXYA13Ei7BB8QgBTTke/8l6zXvW0B/iHherLt118jCZv9iHd8yKLIV
 g9sCYC+kUEykSkbqTIIEc7BL5b7w9oc5/VwPzFbtb2YGI8YaKWr26snEyBnvH6YtmAml
 78adg3/pCzPuC3R1uSOK/pExtheVNktIQaizP3uvTituFL2Jnc3zfo+2KdMCpo5X6F/f
 xHxQ==
X-Gm-Message-State: ABy/qLZQqD4ppCLhHrrUuFrx075/3FagQhnteu/upe+s0PH6oZ+dBPbl
 nwa8odUr6Sbpj5z2Oc4rW/MxIVBcNEcKMpuL6xA=
X-Google-Smtp-Source: APBJJlESyeiWRuN61ZQBxvnwLDdvbAM3fgcvMuBitWZ1rd0rS6V71T3AdE5P4IU0gV/KxG+KMDpBzW8hqeFgHcnkZrY=
X-Received: by 2002:a2e:9e95:0:b0:2b6:eb5a:d377 with SMTP id
 f21-20020a2e9e95000000b002b6eb5ad377mr7310028ljk.5.1690271298922; Tue, 25 Jul
 2023 00:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <e76a29f77bb3f386e4a643c8af94b77b775d1752.1690100802.git.yin31149@gmail.com>
 <CACGkMEuM8JdPhch4uV+3zBSq=8ss99xDwX-KAr9_8_Q8TJ9m+g@mail.gmail.com>
In-Reply-To: <CACGkMEuM8JdPhch4uV+3zBSq=8ss99xDwX-KAr9_8_Q8TJ9m+g@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 25 Jul 2023 15:48:07 +0800
Message-ID: <CAKrof1MxeP2r8uunF_GX2qZuq7KpQ-vz-MQcf5D9rXFto3tTrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa: Restore vlan filtering state
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 2023/7/25 14:47, Jason Wang wrote:
> On Sun, Jul 23, 2023 at 5:28=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch introduces vhost_vdpa_net_load_single_vlan()
>> and vhost_vdpa_net_load_vlan() to restore the vlan
>> filtering state at device's startup.
>>
>> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> But this seems to be a source of latency killer as it may at most send
> 1024 commands.
>
> As discussed in the past, we need a better cvq command to do this: for
> example, a single command to carray a bitmap.

Hi Jason,

Thanks for your review.

You are right, we need some improvement here.

Therefore, I have submitted another patch series titled "vdpa: Send all
CVQ state load commands in parallel" at [1], which allows QEMU to delay
polling and checking the device used buffer until either the SVQ is full
or control commands shadow buffers are full, so that QEMU can send all
the SVQ control commands in parallel, which has better performance
improvement.

To test that patch series, I created 4094 VLANS in guest to build an
environment for sending multiple CVQ state load commands. According to
the result on the real vdpa device at [2], this patch series can improve
latency from 23296 us to 6539 us.

Thanks!

[1]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03726.html
[2]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03947.html


>
> Thanks
>
>> ---
>> v2:
>>   - remove the extra line pointed out by Eugenio
>>
>> v1: https://lore.kernel.org/all/0a568cc8a8d2b750c2e09b2237e9f05cece07c3f=
.1689690854.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 9795306742..347241796d 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -965,6 +965,50 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s=
,
>>       return 0;
>>   }
>>
>> +static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
>> +                                           const VirtIONet *n,
>> +                                           uint16_t vid)
>> +{
>> +    const struct iovec data =3D {
>> +        .iov_base =3D &vid,
>> +        .iov_len =3D sizeof(vid),
>> +    };
>> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_=
VLAN,
>> +                                                  VIRTIO_NET_CTRL_VLAN_=
ADD,
>> +                                                  &data, 1);
>> +    if (unlikely(dev_written < 0)) {
>> +        return dev_written;
>> +    }
>> +    if (unlikely(*s->status !=3D VIRTIO_NET_OK)) {
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
>> +                                    const VirtIONet *n)
>> +{
>> +    int r;
>> +
>> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_VLAN=
)) {
>> +        return 0;
>> +    }
>> +
>> +    for (int i =3D 0; i < MAX_VLAN >> 5; i++) {
>> +        for (int j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
>> +            if (n->vlans[i] & (1U << j)) {
>> +                r =3D vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + =
j);
>> +                if (unlikely(r !=3D 0)) {
>> +                    return r;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>   {
>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>> @@ -995,6 +1039,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> +    r =3D vhost_vdpa_net_load_vlan(s, n);
>> +    if (unlikely(r)) {
>> +        return r;
>> +    }
>>
>>       return 0;
>>   }
>> --
>> 2.25.1
>>
>

