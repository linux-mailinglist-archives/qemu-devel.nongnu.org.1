Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46247D73B8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 20:58:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvj3v-00057j-74; Wed, 25 Oct 2023 14:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1qvj3r-0004xN-Uw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 14:57:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1qvj3o-0004ub-4a
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 14:56:59 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso55977a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1698260210; x=1698865010; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JF5ca7+x0sfEieU/HtiRgSR4K9/JiGdvljdjrfAmMDg=;
 b=oncc96yYBTZKW6rezJjgWfDGzJJMztMBLzY2ta0NJVjPk8rcQP68C+grPOsIIrg6+4
 mW1HnvlL7xaSzpXp+joZs+q0ndud4WmFH1TMB83kIAnuzcBKRB547gD4ZReji4fyo86D
 Ez0Y/Kk6SeTWR2dpPRA0qrfwgyduZ+aoY9qG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698260210; x=1698865010;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JF5ca7+x0sfEieU/HtiRgSR4K9/JiGdvljdjrfAmMDg=;
 b=bOlvEdAzNhS7Ih+LYmkrq7HdvfkWTWWpGfKY2gycGt7Wk9s/NWJUrOyhYn2YEcGbA8
 lTbQdp9Mr5MxHX8eO59h/1sbrD+qiQYdkZmsmKDAvUz6xXJ1xr5PF/XmWqAMbX3HwQt0
 sJweu7ItHz/6njd1OUtUCnr7n1bsdC3eoKrrPPfNhsmTUch6nwJL+Mt/q8EsfTrXo6Ss
 p1EYjgJVlY2mGHstMN8src+DKh5uu8JGLxog/DIvEUR1X8AWO4SiKBo9rhuBdHPv7Cqz
 z5wnSK4/MaRiYtXB2vURzFAzAvmbqLKX68Q4qX18W8A1gWkLXYhkRiN/09eWcfYyB1sM
 3jvg==
X-Gm-Message-State: AOJu0YzIblQwTscpEy55+KdWwZU5SxL+pmCKQpVYYft64NIHILpPqn3i
 bkSy0nub90ax8gLEK0lfZvCSOQ==
X-Google-Smtp-Source: AGHT+IFxH1j7TKw+zrvE7NCB/3vXZZrLnWl0t3N2wKXEX65s3P/uyzFzibytV4tFS6LlcMIDzGoFgw==
X-Received: by 2002:a05:6402:5188:b0:53e:7eca:5650 with SMTP id
 q8-20020a056402518800b0053e7eca5650mr14140934edd.13.1698260210346; 
 Wed, 25 Oct 2023 11:56:50 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 gy5-20020a0564025bc500b0053d9cb67248sm9782173edb.18.2023.10.25.11.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 11:56:50 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------FpeNP3Ap5IjP2UdppoSTSNsb"
Message-ID: <21e8a265-bf5a-464c-86bc-f0fd7b5eb108@citrix.com>
Date: Wed, 25 Oct 2023 19:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/28] docs: update Xen-on-KVM documentation
Content-Language: en-GB
To: David Woodhouse <dwmw2@infradead.org>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-29-dwmw2@infradead.org>
 <6vbpkrebc7fpypbv2t7jbs7m3suxwbqqykeomzfxpenjj2sogd@rphcppcl4inl>
 <4a10a50e5469480a82cb993dedbff10c3d777082.camel@infradead.org>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <4a10a50e5469480a82cb993dedbff10c3d777082.camel@infradead.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=andrew.cooper@cloud.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------FpeNP3Ap5IjP2UdppoSTSNsb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/10/2023 7:26 pm, David Woodhouse wrote:
> On Wed, 2023-10-25 at 13:20 -0500, Eric Blake wrote:
>> On Wed, Oct 25, 2023 at 03:50:42PM +0100, David Woodhouse wrote:
>>> +
>>> +Booting Xen PV guests
>>> +---------------------
>>> +
>>> +Booting PV guest kernels is possible by using the Xen PV shim (a version of Xen
>>> +itself, designed to run inside a Xen HVM guest and provide memory management
>>> +services for one guest alone).
>>> +
>>> +The Xen binary is provided as the ``-kernel`` and the guest kernel itself (or
>>> +PV Grub image) as the ``-initrd`` image, which actually just means the first
>>> +multiboot "module". For example:
>>> +
>>> +.. parsed-literal::
>>> +
>>> +  |qemu_system| --accel kvm,xen-version=0x40011,kernel-irqchip=split \\
>>> +       -chardev stdio,id=char0 -device xen-console,chardev=char0 \\
>>> +       -display none  -m 1G  -kernel xen -initrd bzImage \\
>>> +       -append "pv-shim console=xen,pv -- console=hvc0 root=/dev/xvda1" \\
>>> +       -drive file=${GUEST_IMAGE},if=xen
>> Is the space between -- and console= intentionsl?
> Yes, that one is correct. The -- is how you separate Xen's command line
> (on the left) from the guest kernel command line (on the right).

To expand on this a bit.

Multiboot1 supports multiple modules but only a single command line.  As
one of the modules passed to Xen is the dom0 kernel, we need some way to
pass it's command line, hence the " -- ".

Multiboot2 and PVH support a command line per module, which is the
preferred way to pass the commandlines, given a choice.

~Andrew
--------------FpeNP3Ap5IjP2UdppoSTSNsb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 25/10/2023 7:26 pm, David Woodhouse
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:4a10a50e5469480a82cb993dedbff10c3d777082.camel@infradead.org">
      <pre class="moz-quote-pre" wrap="">On Wed, 2023-10-25 at 13:20 -0500, Eric Blake wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Wed, Oct 25, 2023 at 03:50:42PM +0100, David Woodhouse wrote:<span
        style="white-space: pre-wrap">
</span></pre>
      </blockquote>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+
+Booting Xen PV guests
+---------------------
+
+Booting PV guest kernels is possible by using the Xen PV shim (a version of Xen
+itself, designed to run inside a Xen HVM guest and provide memory management
+services for one guest alone).
+
+The Xen binary is provided as the ``-kernel`` and the guest kernel itself (or
+PV Grub image) as the ``-initrd`` image, which actually just means the first
+multiboot "module". For example:
+
+.. parsed-literal::
+
+  |qemu_system| --accel kvm,xen-version=0x40011,kernel-irqchip=split \\
+       -chardev stdio,id=char0 -device xen-console,chardev=char0 \\
+       -display none  -m 1G  -kernel xen -initrd bzImage \\
+       -append "pv-shim console=xen,pv -- console=hvc0 root=/dev/xvda1" \\
+       -drive file=${GUEST_IMAGE},if=xen
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Is the space between -- and console= intentionsl?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, that one is correct. The -- is how you separate Xen's command line
(on the left) from the guest kernel command line (on the right).</pre>
    </blockquote>
    <br>
    To expand on this a bit.<br>
    <br>
    Multiboot1 supports multiple modules but only a single command
    line.  As one of the modules passed to Xen is the dom0 kernel, we
    need some way to pass it's command line, hence the " -- ".<br>
    <br>
    Multiboot2 and PVH support a command line per module, which is the
    preferred way to pass the commandlines, given a choice.<br>
    <br>
    ~Andrew<br>
  </body>
</html>

--------------FpeNP3Ap5IjP2UdppoSTSNsb--

