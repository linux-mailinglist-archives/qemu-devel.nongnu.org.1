Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56399ADACA
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Oct 2024 06:05:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3p52-0003tR-Lr; Thu, 24 Oct 2024 00:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t3p4z-0003tB-1w; Thu, 24 Oct 2024 00:04:09 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t3p4w-0003er-JE; Thu, 24 Oct 2024 00:04:08 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ed67cfc1fcso272543a12.1; 
 Wed, 23 Oct 2024 21:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729742645; x=1730347445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Xp3qAEej4x30ryWuG56ZWkoQUXGvoHo8cH5h5JzuwTU=;
 b=YmRb39krtfvyYdOQBqvJmpUbFtx8MaGRM0JDuC+vWX4sW8zGBvFsIfI2xxfrjWmmaq
 x2YULvgqa/dWq347+hkt+5rSY1beOhW7Z44Us8Z2SoWzEBkXM4wUAiTH+1i5ZcxRV/3T
 6OcfMjtuPSKnWoiC4OWBwwH8MNTG4Hoc3Kq3Sh04XLhuUyqzwddPILGaz6EPRph5qDLI
 kTq7UXHootDRKu95KDvVd9++F+2mQFPGJyw2k8tcDgiSJiJJndnD9naL6BYKWOgzjUke
 gKE+dOqLiWxicE0ZdHZKPrhcq0Rrw6DvZXS0VQt7CdtCfLqNcvWYHRfDsNd9zjaixRjl
 14qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729742645; x=1730347445;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xp3qAEej4x30ryWuG56ZWkoQUXGvoHo8cH5h5JzuwTU=;
 b=f469bGg+gfLhuf+2+k0SD4bsqA2EcCh21jbuZWiYDWx1/WA17nj9NiPQyH5eWNCLO0
 /bElpwkBGX3Yp6j4z1O5+YetFk1fhVMonpGw5ZrDgw0h/KZJiBKeI6mK74uU0UGvaZds
 ufq6Y06X68p8f9QJ3V7ThprKuxEh03/D3D9v0NBGRIlFB8kfDR7YXJllMzc1Vt8tUJbl
 tz4vv60CgC97MrczKLvivz4ghqzFS84KukxUh2pnHTn5n2Jlf8R1o9BQN3FHtkkDTNfB
 yUSmxwFDQuLRHL/V4cziaw40YKJVQ+7fTVIZ3Zgk7gmG7pz8NI18vNS7MZiwyX7QMefF
 PjvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXICOxJLgkAiKNpwSZLXlAz2qbbyIIxlwtCXFWJDoCfA9tC7IbQJZrLDnzc/HPUb0J80Zhq8gtnzv/i@nongnu.org
X-Gm-Message-State: AOJu0Ywjjk/8Dttux2RANmAHU8ejmSM59cW7XPES2+t9RmRIefrV7SVO
 Eu6IyaYatgaxvk9SDESMsb2IeRAJcyFx1tDTSQ95ENWcT4vy2hyz
X-Google-Smtp-Source: AGHT+IE9mYHdrHQvULLl8jNms82w91nnbzY1dIuHl6LYnEFILScTlnhh3khnlkdkUGB5T/ZO7TIbWw==
X-Received: by 2002:a05:6a21:1709:b0:1d9:252f:a074 with SMTP id
 adf61e73a8af0-1d978b3dc9emr6177232637.22.1729742644530; 
 Wed, 23 Oct 2024 21:04:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d742dsm7061984b3a.119.2024.10.23.21.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 21:04:03 -0700 (PDT)
Message-ID: <a49719b7-e3fb-46ca-b884-cb7019a0b09f@roeck-us.net>
Date: Wed, 23 Oct 2024 21:04:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 51/98] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-52-philmd@linaro.org>
 <94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net>
 <7965f970-cdbd-4e3e-bc4c-62fb496a9e24@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7965f970-cdbd-4e3e-bc4c-62fb496a9e24@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/23/24 20:27, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 23/10/24 19:24, Guenter Roeck wrote:
>> Hi,
>>
>> On Fri, Jun 28, 2024 at 09:01:27AM +0200, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>
>> This patch results in:
>>
>> [    5.976133] Waiting for root device /dev/mmcblk0...
>> [    6.501462] mmc0: error -38 whilst initialising SD card
>> [    7.557473] mmc0: error -38 whilst initialising SD card
>>
>> ... (repeated until session is aborted)
>>
>> when trying to boot Linux for sifive_u from sd card.
>> The command used to boot the image is
>>
>> qemu-system-riscv64 -M sifive_u -m 512M -no-reboot \
>>      -kernel arch/riscv/boot/Image \
>>      -snapshot -drive file=rootfs.ext2,format=raw,if=sd \
>>      -bios default \
>>      -append "root=/dev/mmcblk0 rootwait console=ttySIF0,115200 earlycon" \
>>      -nographic -monitor none
>>
>> Bisect log is attached.
>>
>> Guenter
>>
>> ---
>> # bad: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 release
>> # good: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 release
>> git bisect start 'HEAD' 'v9.0.0'
>> # good: [2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219] hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
>> git bisect good 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
>> # bad: [76e375fc3c538bd6e4232314f693b56536a50b73] docs/qapidoc: add QMP highlighting to annotated qmp-example blocks
>> git bisect bad 76e375fc3c538bd6e4232314f693b56536a50b73
>> # good: [720c0f3e6cf856fa62c06a8f0005d814684c30d9] hw/sd/sdcard: Register generic optional handlers (CMD11 and CMD20)
>> git bisect good 720c0f3e6cf856fa62c06a8f0005d814684c30d9
>> # bad: [5915139aba1646220630596de30c673528e047c9] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
>> git bisect bad 5915139aba1646220630596de30c673528e047c9
>> # bad: [188569c10d5dc6996bde90ce25645083e9661ecb] target/i386/SEV: implement mask_cpuid_features
>> git bisect bad 188569c10d5dc6996bde90ce25645083e9661ecb
>> # bad: [8442e1625ba6723bee2c6d0fdb7207a3e27a2b05] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
>> git bisect bad 8442e1625ba6723bee2c6d0fdb7207a3e27a2b05
>> # bad: [96f3d00ac1680f978984314d24ae6f2f6f281fdc] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
>> git bisect bad 96f3d00ac1680f978984314d24ae6f2f6f281fdc
>> # good: [1ec3cb893fa8883f5baf69850a4d0a97502bbad8] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
>> git bisect good 1ec3cb893fa8883f5baf69850a4d0a97502bbad8
>> # bad: [9318be060506be33a0fbf01198b0024fdeb28f39] hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler (CMD15)
>> git bisect bad 9318be060506be33a0fbf01198b0024fdeb28f39
>> # bad: [030897e89d3dff8ef7efd5cc570612da4476734f] hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler (CMD12)
>> git bisect bad 030897e89d3dff8ef7efd5cc570612da4476734f
>> # bad: [da954d0e32444f122a41c24948d4d1c718bf66d4] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
>> git bisect bad da954d0e32444f122a41c24948d4d1c718bf66d4
>> # first bad commit: [da954d0e32444f122a41c24948d4d1c718bf66d4] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
> 
> I don't have access to my workstation, but looking at the patch,
> maybe the fix is simply:
> 
> ---
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a5d2d929a8a..1594d340a6e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1567,7 +1567,7 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
>   /* CMD9 */
>   static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
>   {
> -    if (sd->state != sd_standby_state) {
> +    if (sd->state != sd_transfer_state) {
>           return sd_invalid_state_for_cmd(sd, req);
>       }
>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> @@ -1586,7 +1586,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
>   /* CMD10 */
>   static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
>   {
> -    if (sd->state != sd_standby_state) {
> +    if (sd->state != sd_transfer_state) {
>           return sd_invalid_state_for_cmd(sd, req);
>       }
>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> ---
> 
> Is it possible for you to test this snippet?
> 

It must be related, but something else must be wrong. With the above, I get

[    4.355063] Run /sbin/init as init process
ssi_sd: error: Unexpected response to cmd 13
[    4.780139] mmc0: SPI card removed
[    4.785194] EXT4-fs (mmcblk0): shut down requested (2)
[    4.812689] Starting init: /sbin/init exists but couldn't execute it (error -5)
[    4.813248] Run /etc/init as init process
[    4.825799] init: attempt to access beyond end of device

The state is always 4 when spi_cmd_SEND_CSD() and spi_cmd_SEND_CID()
are called. With more debugging added:

ssi_sd: error: Unexpected response to cmd 13 (arglen expected 4, got 16)

Changing only one of the functions to check against sd_transfer_state
doesn't help either; that brings back the repeated error -38.

Guenter


